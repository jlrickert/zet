# Project: Database to local FS mount

CMS typically have a crappy UI for editing HTML and CSS. Mount the relevant rows to allow doing CRUD operations on them.

## AI GO Example

This doesn't work but will get you started

```go
package main

import (
	"context"
	"database/sql"
	"flag"
	"fmt"
	"log"
	"sync"
	"syscall"

	_ "github.com/go-sql-driver/mysql"
	"github.com/hanwen/go-fuse/v2/fs"
	"github.com/hanwen/go-fuse/v2/fuse"
)

// TemplateFile is a file node backed by a specific DB field
type TemplateFile struct {
	fs.Inode
	db         *sql.DB
	templateID int
	fieldName  string // "content" or "description"
	mu         sync.Mutex
}

var _ = (fs.NodeReadFile)((*TemplateFile)(nil))
var _ = (fs.NodeSetattrer)((*TemplateFile)(nil))

func (f *TemplateFile) Read(ctx context.Context, dest []byte, off int64) (fuse.ReadResult, syscall.Errno) {
	f.mu.Lock()
	defer f.mu.Unlock()

	var data string
	err := f.db.QueryRowContext(ctx,
		fmt.Sprintf("SELECT %s FROM cms_layout_templates WHERE id=?", f.fieldName),
		f.templateID).Scan(&data)
	if err != nil {
		log.Printf("Read DB error: %v", err)
		return nil, syscall.EIO
	}

	// Handle offset
	if int(off) >= len(data) {
		return fuse.ReadResultData(nil), 0
	}
	sl := []byte(data)
	if int(off)+len(dest) > len(sl) {
		dest = dest[:len(sl)-int(off)]
	}
	return fuse.ReadResultData(sl[off : off+int64(len(dest))]), 0
}

// Write updates the DB field with new data
func (f *TemplateFile) Write(ctx context.Context, data []byte, off int64) (uint32, syscall.Errno) {
	f.mu.Lock()
	defer f.mu.Unlock()

	// Read current data
	var current string
	err := f.db.QueryRowContext(ctx,
		fmt.Sprintf("SELECT %s FROM cms_layout_templates WHERE id=?", f.fieldName),
		f.templateID).Scan(&current)
	if err != nil {
		log.Printf("Write read DB error: %v", err)
		return 0, syscall.EIO
	}

	// Modify current content with new data
	// Convert to slice []byte for modification
	contentBytes := []byte(current)
	endPos := int(off) + len(data)
	if endPos > len(contentBytes) {
		// Extend slice to accommodate writes beyond current length
		newContent := make([]byte, endPos)
		copy(newContent, contentBytes)
		contentBytes = newContent
	}
	copy(contentBytes[off:], data)

	updated := string(contentBytes)

	// Update DB field with new content
	_, err = f.db.ExecContext(ctx,
		fmt.Sprintf("UPDATE cms_layout_templates SET %s = ?, modified = UNIX_TIMESTAMP() WHERE id=?", f.fieldName),
		updated, f.templateID)
	if err != nil {
		log.Printf("DB update error: %v", err)
		return 0, syscall.EIO
	}

	return uint32(len(data)), 0
}

// Getattr returns file attributes for content and description files
func (f *TemplateFile) Getattr(ctx context.Context, fh fs.FileHandle, out *fuse.AttrOut) syscall.Errno {
	out.Mode = 0644
	return 0
}

// TemplateDir represents a directory named `id-name` with files content and description
type TemplateDir struct {
	fs.Inode
	db         *sql.DB
	templateID int
	name       string
}

var _ = (fs.NodeLookuper)((*TemplateDir)(nil))
var _ = (fs.NodeGetattrer)((*TemplateDir)(nil))

func (d *TemplateDir) Lookup(ctx context.Context, name string, out *fuse.EntryOut) (*fs.Inode, syscall.Errno) {
	switch name {
	case "content", "description":
		child := &TemplateFile{
			db:         d.db,
			templateID: d.templateID,
			fieldName:  name,
		}
		ch := d.NewPersistentInode(ctx, child, fs.StableAttr{Ino: uint64(d.templateID*10 + len(name))})
		return ch, 0
	default:
		return nil, syscall.ENOENT
	}
}

func (d *TemplateDir) Getattr(ctx context.Context, fh fs.FileHandle, out *fuse.AttrOut) syscall.Errno {
	out.Mode = 0755 | fuse.S_IFDIR
	return 0
}

// CmsRoot is the root node that lists all templates under templates/
type CmsRoot struct {
	fs.Inode
	db *sql.DB
}

var _ = (fs.NodeLookuper)((*CmsRoot)(nil))
var _ = (fs.NodeGetattrer)((*CmsRoot)(nil))
var _ = (fs.NodeReaddirer)((*CmsRoot)(nil))

func (r *CmsRoot) Lookup(ctx context.Context, name string, out *fuse.EntryOut) (*fs.Inode, syscall.Errno) {
	// For simplicity, we expose a single directory "templates"
	if name == "templates" {
		d := &TemplatesDir{
			db: r.db,
		}
		ch := r.NewPersistentInode(ctx, d, fs.StableAttr{Ino: 2})
		return ch, 0
	}
	return nil, syscall.ENOENT
}

func (r *CmsRoot) Getattr(ctx context.Context, fh fs.FileHandle, out *fuse.AttrOut) syscall.Errno {
	out.Mode = 0755 | fuse.S_IFDIR
	return 0
}

// TemplatesDir lists all templates as directories
type TemplatesDir struct {
	fs.Inode
	db *sql.DB
}

var _ = (fs.NodeReaddirer)((*TemplatesDir)(nil))
var _ = (fs.NodeLookuper)((*TemplatesDir)(nil))

func (d *TemplatesDir) Readdir(ctx context.Context) (fs.DirStream, syscall.Errno) {
	rows, err := d.db.QueryContext(ctx, "SELECT id, name FROM cms_layout_templates")
	if err != nil {
		log.Printf("DB query error: %v", err)
		return nil, syscall.EIO
	}
	defer rows.Close()

	var entries []fuse.DirEntry
	for rows.Next() {
		var id int
		var name string
		if err := rows.Scan(&id, &name); err != nil {
			return nil, syscall.EIO
		}
		ename := fmt.Sprintf("%d-%s", id, name)
		entries = append(entries, fuse.DirEntry{Name: ename, Mode: fuse.S_IFDIR})
	}

	return fs.NewListDirStream(entries), 0
}

func (d *TemplatesDir) Lookup(ctx context.Context, name string, out *fuse.EntryOut) (*fs.Inode, syscall.Errno) {
	// name format: "id-name"
	var id int
	var title string
	n, err := fmt.Sscanf(name, "%d-%s", &id, &title)
	if n != 2 || err != nil {
		return nil, syscall.ENOENT
	}

	child := &TemplateDir{
		db:         d.db,
		templateID: id,
		name:       name,
	}
	ch := d.NewPersistentInode(ctx, child, fs.StableAttr{Ino: uint64(id)})
	return ch, 0
}

func main() {
	debug := flag.Bool("debug", false, "print debug data")
	flag.Parse()
	if len(flag.Args()) < 1 {
		log.Fatal("Usage:\n  main MOUNTPOINT")
	}

	// NOTE: Update below DSN for your mariadb connection: user:pass@tcp(host:port)/primomed.202504
	db, err := sql.Open("mysql", "user:pass@tcp(localhost:3306)/primomed.202504")
	if err != nil {
		log.Fatalf("DB open error: %v", err)
	}
	defer db.Close()

	opts := &fs.Options{}
	opts.Debug = *debug
	server, err := fs.Mount(flag.Arg(0), &CmsRoot{db: db}, opts)
	if err != nil {
		log.Fatalf("Mount fail: %v\n", err)
	}
	server.Wait()
}
```

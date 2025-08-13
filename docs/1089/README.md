# Go release strategy

This repository uses [git-chglog](../1100) and [GoReleaser](../1101) to generate changelogs and produce release artifacts. Tagging a new version (semver, e.g. v1.2.3) triggers the release pipeline (CI or local), which runs goreleaser to build and publish artifacts.

This document describes the local setup, the release flow, and the example helper scripts and config used in this project.

Prerequisites

- git
- Go (as required by your project)
- git-chglog (for changelog generation)
- goreleaser (for building releases and artifacts)
- task (optional, for Taskfile convenience)

Mac setup

```bash
# install git-chglog
brew tap git-chglog/git-chglog
brew install git-chglog

# install goreleaser (cask or regular Homebrew tap)
brew install goreleaser/tap/goreleaser
# or: brew install goreleaser
```

Release flow (high level)

1. Ensure your working tree is clean.
2. Determine latest tag (or v0.0.0 if none).
3. Inspect commits since the latest tag and decide the next bump (major/minor/patch) using conventional commit cues:
   - BREAKING CHANGE or type! -> major
   - feat -> minor
   - fix/perf/security -> patch
   - otherwise no release
4. Generate changelog for the next tag with git-chglog.
5. Commit the changelog and create an annotated tag.
6. Push branch and tag.
7. Run goreleaser (locally or via CI) to produce artifacts and optionally publish a GitHub release.

Note: You can automate this with a small Go helper script (example below) and/or Taskfile tasks.

Example: release helper (hack/release/main.go)

This example script decides the next version from commits and automates changelog generation, commit, tagging, and push. It assumes conventional commit messages.

```go
package main

import (
	"bytes"
	"context"
	"errors"
	"fmt"
	"os"
	"os/exec"
	"regexp"
	"strings"

	semver "github.com/Masterminds/semver/v3"
)

func run(ctx context.Context, name string, args ...string) (string, error) {
	cmd := exec.CommandContext(ctx, name, args...)
	var out bytes.Buffer
	cmd.Stdout = &out
	cmd.Stderr = &out
	err := cmd.Run()
	return strings.TrimSpace(out.String()), err
}

func latestTag(ctx context.Context) (string, error) {
	out, err := run(ctx, "git", "describe", "--tags", "--abbrev=0")
	if err != nil {
		// no tags yet -> treat as v0.0.0
		return "v0.0.0", nil
	}
	return out, nil
}

func commitsSince(ctx context.Context, tag string) (string, error) {
	out, err := run(ctx, "git", "log", fmt.Sprintf("%s..HEAD", tag), "--pretty=format:%s%n%n%b")
	if err != nil {
		return "", err
	}
	return out, nil
}

func decideBump(commits string) (string, error) {
	// detect breaking change in body or "type!:" syntax
	breakingRe := regexp.MustCompile(`(?m)BREAKING CHANGE|^[a-zA-Z]+(!):`)
	if breakingRe.MatchString(commits) {
		return "major", nil
	}
	// detect feat:
	feature := regexp.MustCompile(`(?m)^(feat)(\(|:)?`)
	if feature.MatchString(commits) {
		return "minor", nil
	}
	// detect fix:
	fixRe := regexp.MustCompile(`(?m)^(?:fix|perf|security)(\(|:)?`)
	if fixRe.MatchString(commits) {
		return "patch", nil
	}
	return "", errors.New("no release needed")
}

func bumpVersion(old string, kind string) (string, error) {
	verStr := strings.TrimPrefix(old, "v")
	v, err := semver.NewVersion(verStr)
	if err != nil {
		return "", err
	}
	maj := int(v.Major())
	min := int(v.Minor())
	pat := int(v.Patch())

	switch kind {
	case "major":
		maj++
		min = 0
		pat = 0
	case "minor":
		min++
		pat = 0
	case "patch":
		pat++
	default:
		return "", fmt.Errorf("unknown bump kind: %s", kind)
	}
	return fmt.Sprintf("v%d.%d.%d", maj, min, pat), nil
}

func main() {
	ctx := context.Background()
	// ensure git working dir is clean
	if out, _ := run(ctx, "git", "status", "--porcelain"); out != "" {
		fmt.Fprintln(os.Stderr, "working tree not clean; commit or stash changes first")
		os.Exit(1)
	}

	tag, err := latestTag(ctx)
	if err != nil {
		fmt.Fprintln(os.Stderr, "failed to get latest tag:", err)
		os.Exit(1)
	}
	fmt.Println("latest tag:", tag)

	commits, err := commitsSince(ctx, tag)
	if err != nil {
		fmt.Fprintln(os.Stderr, "failed to get commits:", err)
		os.Exit(1)
	}
	if strings.TrimSpace(commits) == "" {
		fmt.Println("no commits since last tag; nothing to release")
		os.Exit(0)
	}

	kind, err := decideBump(commits)
	if err != nil {
		fmt.Println("no release needed (no feat/fix/BREAKING)")
		os.Exit(0)
	}
	fmt.Println("decided bump:", kind)

	nextTag, err := bumpVersion(tag, kind)
	if err != nil {
		fmt.Fprintln(os.Stderr, "failed to bump version:", err)
		os.Exit(1)
	}
	fmt.Println("next tag will be:", nextTag)

	// Generate changelog for the next tag (requires git-chglog installed)
	fmt.Println("generating changelog with git-chglog...")
	if _, err := run(ctx, "git-chglog", "--next-tag", nextTag, "-o", "CHANGELOG.md"); err != nil {
		fmt.Fprintln(os.Stderr, "git-chglog failed:", err)
		os.Exit(1)
	}

	// commit changelog and create annotated tag
	if _, err := run(ctx, "git", "add", "CHANGELOG.md"); err != nil {
		fmt.Fprintln(os.Stderr, "git add failed:", err)
		os.Exit(1)
	}

	msg := fmt.Sprintf("chore(release): %s", nextTag)
	if _, err := run(ctx, "git", "commit", "-m", msg); err != nil {
		fmt.Fprintln(os.Stderr, "git commit failed:", err)
		os.Exit(1)
	}

	if _, err := run(ctx, "git", "tag", "-a", nextTag, "-m", nextTag); err != nil {
		fmt.Fprintln(os.Stderr, "git tag failed:", err)
		os.Exit(1)
	}

	// push branch and tag
	if _, err := run(ctx, "git", "push"); err != nil {
		fmt.Fprintln(os.Stderr, "git push failed:", err)
		os.Exit(1)
	}
	if _, err := run(ctx, "git", "push", "origin", nextTag); err != nil {
		fmt.Fprintln(os.Stderr, "git push tag failed:", err)
		os.Exit(1)
	}

	fmt.Println("tag pushed:", nextTag)
	fmt.Println("Now run goreleaser (locally or let CI run it) to produce artifacts and GitHub release.")
	fmt.Println("goreleaser release --snapshot --clean")
}
```

[Taskfile](../1102) (Taskfile.yml)

This Taskfile provides convenience tasks for running, building, testing, generating changelogs, and releasing.

```yaml
# https://taskfile.dev
version: "3"
vars:
  VERSION: v1.0.0
tasks:
  run:
    cmd: go run ./cmd/ecw
    silent: true
  build:
    - go build -ldflags "-X github.com/jlrickert/example/pkg/example/cmd.Version={{.VERSION}}" ./cmd/example
  install:
    desc: ""
    cmds:
      - go install ./cmd/ecw
      - ecw completion zsh > '{{env "HOME"}}/.cache/dotfiles/zsh/completions/_ecw'
  test:
    cmd: go test ./...
  test-watch:
    - fd go | entr task test
  watch:
    cmds:
      - fd go | entr task install
  changelog:
    cmds:
      - git-chglog
    generates:
      - CHANGELOG.md
  release:
    desc: Bump version, generate changelog, tag & push, build artifacts, upload to Bitbucket Downloads
    cmds:
      - go run ./hack/release
      - goreleaser release --snapshot --clean
      # - ./hack/upload_to_bitbucket.sh
```

.goreleaser.yaml (example)

This is an example GoReleaser configuration with sensible defaults. Adjust as needed for your project and CI.

```yaml
# Schema: https://goreleaser.com/static/schema.json
# yaml-language-server: $schema=https://goreleaser.com/static/schema.json

version: 2
before:
  hooks:
    - go mod tidy
    - go generate ./...
builds:
  - id: default
    binary: example
    main: ./cmd/example
    env:
      - CGO_ENABLED=0
    goos:
      - linux
      - windows
      - darwin
      - freebsd
    goarch:
      - amd64
      - "386"
      - arm64
    ldflags:
      - -s -w -X github.com/jlrickert/example/pkg/example/cmd.Version={{ .Version }}
    hooks: {}
archives:
  - id: default
    formats:
      - tar.gz
    files:
      - LICENSE
      - README.md
      - CHANGELOG.md
    name_template: "{{ .ProjectName }}_{{ .Version }}_{{ .Os }}_{{ .Arch }}{{ if .Arm }}v{{ .Arm }}{{ end }}"
    format_overrides:
      - goos: windows
        formats:
          - zip
checksum:
  name_template: "{{ .ProjectName }}_{{ .Version }}_checksums.txt"
changelog:
  sort: asc
  filters:
    exclude:
      - "^docs:"
      - "^test:"
signs: []
release:
  footer: |-
    ---
    Released by GoReleaser.
```

git-chglog configuration (./.chglog/config.yml)

Example configuration for git-chglog that groups commits by type and supports BREAKING CHANGE notes.

```yaml
style: github
template: CHANGELOG.tpl.md
info:
  title: CHANGELOG
  repository_url: https://github.com/jlrickert/example
options:
  commits:
    filters:
      Type:
        - feat
        - fix
        - perf
        - security
        - refactor
        - chore
  commit_groups:
    title_maps:
      feat: Features
      fix: Bug Fixes
      perf: Performance Improvements
      security: Security Improvements
      refactor: Code Refactoring
      chore: Chores
  header:
    pattern: "^(\\w*)(?:\\(([\\w\\$\\.\\-\\*\\s]*)\\))?\\:\\s(.*)$"
    pattern_maps:
      - Type
      - Scope
      - Subject
  notes:
    keywords:
      - BREAKING CHANGE
```

CHANGELOG template (./chglog/CHANGELOG.tpl.md)

A simple template used by git-chglog to render changelogs.

```text
{{ if .Versions -}}
<a name="unreleased"></a>
## [Unreleased]

{{ if .Unreleased.CommitGroups -}}
{{ range .Unreleased.CommitGroups -}}
### {{ .Title }}
{{ range .Commits -}}
- {{ if .Scope }}**{{ .Scope }}:** {{ end }}{{ .Subject }}
{{ end }}
{{ end -}}
{{ end -}}
{{ end -}}

{{ range .Versions }}
<a name="{{ .Tag.Name }}"></a>
## {{ if .Tag.Previous }}[{{ .Tag.Name }}]{{ else }}{{ .Tag.Name }}{{ end }} - {{ datetime "2006-01-02" .Tag.Date }}
{{ range .CommitGroups -}}
### {{ .Title }}
{{ range .Commits -}}
- {{ if .Scope }}**{{ .Scope }}:** {{ end }}{{ .Subject }}
{{ end }}
{{ end -}}

{{- if .RevertCommits -}}
### Reverts
{{ range .RevertCommits -}}
- {{ .Revert.Header }}
{{ end }}
{{ end -}}

{{- if .MergeCommits -}}
### Pull Requests
{{ range .MergeCommits -}}
- {{ .Header }}
{{ end }}
{{ end -}}

{{- if .NoteGroups -}}
{{ range .NoteGroups -}}
### {{ .Title }}
{{ range .Notes }}
{{ .Body }}
{{ end }}
{{ end -}}
{{ end -}}
{{ end -}}

{{- if .Versions }}
[Unreleased]: {{ .Info.RepositoryURL }}/compare/{{ $latest := index .Versions 0 }}{{ $latest.Tag.Name }}...HEAD
{{ range .Versions -}}
{{ if .Tag.Previous -}}
[{{ .Tag.Name }}]: {{ $.Info.RepositoryURL }}/compare/{{ .Tag.Previous.Name }}...{{ .Tag.Name }}
{{ end -}}
{{ end -}}
{{ end -}}
```

To create a release locally

```bash
task release
# or manually:
# 1. run ./hack/release (generates CHANGELOG.md, commits, tags, and pushes)
# 2. run goreleaser release --rm-dist
```

CI/CD

- Add goreleaser to your CI pipeline to run on new tags (or let goreleaser run in a release pipeline).
- Ensure any required secrets (e.g. GitHub token, signing keys) are available in CI.
- Optionally publish artifacts to homebrew, chocolatey, GitHub Releases, or other providers via goreleaser configuration.

Notes and tips

- Use conventional commits to allow automated bump detection and changelog generation.
- Keep your .goreleaser.yml and git-chglog config under source control and adapt to project conventions.
- Test the release flow in a branch and use dry-run/snapshot flags locally: goreleaser release --snapshot --clean

If you want, I can:

- Tailor the .goreleaser.yml to your exact project layout.
- Add CI example (GitHub Actions) that runs on tag push and runs goreleaser.
- Add instructions for signing or uploading to specific providers.

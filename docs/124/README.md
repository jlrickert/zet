# Sync a directory with rsync

Here is the command in question

```bash
rsync -avv jlrickert@jlrickert.me:/home/crazy_app/public_html/application/files/ application/files
```

The `-a` is an alias for `--archive`. This is the same as `-rlptgoD`.

| Option | Description                                                    |
| ------ | -------------------------------------------------------------- |
| `-r`   | recursive                                                      |
| `-l`   | copy symlinks as symlinks                                      |
| `-p`   | preserve permissions                                           |
| `-t`   | preserve times                                                 |
| `-g`   | preserve group                                                 |
| `-o`   | preserve owner (sudo only)                                     |
| `-D`   | same as `--devices --specials`. Ignored under most conditions. |

The `-v` just adds more verbosity.

The ending `/` in for the source directory keeps `rsync` from creating nested directories. For example, it is not desirable to have `file/file` when we want `file`. This is a common error that I find myself making often. This will overwrite files. If you want to _sync_ add the `--delete` flag.

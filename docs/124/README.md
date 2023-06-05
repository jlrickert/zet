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

    tags: #cli

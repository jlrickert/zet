# How to set path variables on MacOS

System wide paths are found in `/etc/paths`

Example of how I add `/usr/local/bin` and `~/scripts` to my PATH variable in `~/.zshrc`

```bash
typeset -U
path+=(
  "$SCRIPTS"
  /usr/local/bin
)
```

Meta

    tags: #macOS #linux #cli

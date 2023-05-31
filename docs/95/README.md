# How to set path variables on MacOS

System wide paths are found in `/etc/paths`

Example of how I set my path variables in ~/.zshrc

```bash
typeset -U
path+=(
  "$SCRIPTS"
  "$HOME/.local/bin"
  "$HOME/.local/share/flutter/bin"
  "$CARGO_HOME/bin"
  "$FNM_HOME"
  /usr/local/go/bin
  /usr/local/bin
  /usr/local/bin
  /usr/local/sbin
  /usr/local/games
  /usr/games
  /usr/sbin
  /usr/bin
  /snap/bin
  /sbin
  /bin
)
```

Meta

    tags: #macOS #linux

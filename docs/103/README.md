# Tiling window management on macOS with Yabai

See [docs] for how to install

[docs]: https://github.com/koekeishiya/yabai/wiki

## Dump

```bash
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
```

```bash
cp /opt/homebrew/opt/skhd/share/skhd/examples/skhdrc ~/.skhdrc
cp /opt/homebrew/opt/yabai/share/yabai/examples/yabairc ~/.yabairc
```

```bash
# start service
skhd --start-service
# stop service
skhd --stop-service
# restart
skhd --stop-service && skhd --start-service
```

```bash
# start service
yabai --start-service
# stop service
yabai --stop-service
# restart
yabai --stop-service && yabai --start-service
```

For hacking on configs

```bash
ls .skhdrc  | entr -s 'skhd --stop-service && skhd --start-service'
ls .yabirc  | entr -s 'yabai --stop-service && yabai --start-service'
```

References:

- [official docs](https://github.com/koekeishiya/yabai/wiki)
- [josean blog post](https://www.josean.com/posts/yabai-setup)
- [josean's dotfiles](https://github.com/josean-dev/dev-environment-files)
- [anuj-chandra](https://anuj-chandra.medium.com/using-i3-like-tiling-window-managers-in-macos-with-yabai-ebf0e002b992)

Meta:

    tags: #macOS #workstation

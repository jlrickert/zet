# App: Tiling window management on macOSX with Yabai

[Yabai](../103) is the tiling window manager that I use on my [mac](../583). Works with [skhd].

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

For hacking on configs. This is actually unnecessary for skhd as restarting is build right into the service. I am keeping it here for reference.

```bash
ls .skhdrc  | entr -s 'skhd --stop-service && skhd --start-service'
ls .yabirc  | entr -s 'yabai --stop-service && yabai --start-service'
```

## Upgrading

Frequently after updating yabai will break. Follow the steps below:

- Edit `/private/etc/sudoers.d/yabai` to update the hash. `echo "jlrickert ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa"` will create the line needed. Typically, I will comment out the previous line.
- Restart with `yabai --stop-service && yabai --start-service`

References:

- [official docs](https://github.com/koekeishiya/yabai/wiki)
- [josean blog post](https://www.josean.com/posts/yabai-setup)
- [josean's dotfiles](https://github.com/josean-dev/dev-environment-files)
- [anuj-chandra](https://anuj-chandra.medium.com/using-i3-like-tiling-window-managers-in-macos-with-yabai-ebf0e002b992)
- [sgoodluck](https://github.com/sgoodluck/mac-dotfiles)

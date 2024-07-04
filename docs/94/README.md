# fzf setup and usage

`fzf` is an interactive unix filter.

- [github](https://github.com/junegunn/fzf)

## Use cases

Use to find an item based on a keyword. To make this smooth a preview should show if the item found.

## Setup

Key pieces

| Item          | Description                                                                   |
| ------------- | ----------------------------------------------------------------------------- |
| fzf binary    | This is the binary to be run                                                  |
| shell scripts | These are files that provide completions and keybindings                      |
| shell config  | This is configuration for fzf. This links to the fzf shell scripts and binary |
| installer     | installs fzf, completions, keybindings, and rc files                          |

### fzf binary

The binary is a program written go. As such, it may be installed with `go get -u github.com/junegunn/fzf`. Running the

Running the installer with `install --bin` will install the binary in the source directory. This needs needs to be further setup by the user. Basic bin binary stuff. I use stow for that.

### Shell config

The install script can be found at the top level of the fzf git repo. If you installed fzf with homebrew on MacOS then it may be found at `/opt/homebrew/opt/fzf/install`

Running `install --no-update-rc --xdg --key-bindings --completion` generate `~/.config/fzf/fzf.zsh` and `~/.config/fzf/fzf.bash`. This prevents the fzf installer from muking up the dotfiles.

Normally the installer will add the following:

```bash
# Update $HOME/.bashrc:
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash

#Update $HOME/.zshrc:
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh
```

## See Also

- [my fzf installation process](https://github.com/dotfiles)

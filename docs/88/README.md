# MacOS workstation setup

- Install Rosetta

  ```bash
  sudo softwareupdate --install-rosetta --agree-to-license
  ```

- Swap escape and caps lock in settings.

  See also

  - [How to swap caps lock](../91)

- Xcode

  This is done by running `xcode-select --install`

- homebrew

  This is installed by running `/bin/bash -c "$(curl -fsSL
https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

- Install vs code

  Installing vs code is done by installing from the [website]. To be
  able to use `code` on the command line run `` Shell Command: Install
`code` command in PATH ``. If this fails you may need to run `` Shell
Command: Uninstall `code` command in PATH ``

- Install [dotfiles]

- Install all the things with brew

  ```bash
  brew install go tmux bat fzf ripgrep stow awk tig gh shfmt shellcheck exa coreutils
  ```

- Install fzf utilitites

  ```bash
  /opt/homebrew/opt/fzf/install --xdg --key-bindings --completion --no-update-rc
  ```

- Install rust

  ```bash
  cd "$(mktemp -d)" || exit 1
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh
  export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
  export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
  if [[ "$(sha256sum rustup.sh | cut -d' ' -f1)" = "be3535b3033ff5e0ecc4d589a35d3656f681332f860c5fd6684859970165ddcc" ]]; then
    sh rustup.sh --no-modify-path
  fi
  ```

- Install utilities with cargo

  ```bash
  cargo install fd-find stylua
  ln -s "$(which fd)" ~/.local/bin/fdfind
  ```

  `fdfind` is used by `fzf` for finding files and directories

- Install [flutter]

- Install [yabai] for tiling window manager

- Install Lando

[dotfiles]: https://github.com/jlrickert/dotfiles
[website]: https://code.visualstudio.com/
[flutter]: ../100

- Setup notifications

  Use spotlight to search for _notifications_

Meta:

    tags: #macOS #workstation

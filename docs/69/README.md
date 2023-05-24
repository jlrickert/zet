# Config files for zsh environment

Config files:

| File name          | Description                            |
| ------------------ | -------------------------------------- |
| $ZDOTDIR/.zshenv   | Environmental variables should go here |
| $ZDOTDIR/.zprofile | if login shell.                        |
| $ZDOTDIR/.zshrc    | if interactive shell.                  |
| $ZDOTDIR/.zlogin   | if login shell                         |
| $ZDOTDIR/.zlogout  | if login shell                         |
| ${TMPPREFIX}\_     | (default is /tmp/zsh\_)                |
| /etc/zsh/zshenv    |
| /etc/zsh/zprofile  | if login shell                         |
| /etc/zsh/zshrc     |
| /etc/zsh/zlogin    | if login shell                         |
| /etc/zsh/zlogout   | if login shell                         |

[useful stuff]: https://linuxconfig.org/zsh-shell-installation-and-configuration-on-linux

Interactive shell loading sequence

1. /etc/zshenv
2. ~/.zshenv
3. /etc/zshrc
4. ~/.zshrc

When using interactive, login shell sessions:

1. /etc/zshenv
2. ~/.zshenv
3. /etc/zprofile
4. ~/.zprofile
5. /etc/zshrc
6. ~/.zshrc
7. /etc/zlogin
8. ~/.zlogin
9. ~/.zlgout
10. /etc/zlogout

Meta:

    #unix #cli #linux

# Patch: Reconfiguring zsh for my dotfiles

Around 2025-06-08 I redid my [zsh](../69) setup for my [dotfiles](../625) to remove oh-my-zsh as a dependency in an attempt to increase performance.

## Dump

- **`sudo su -l test-user`:** Login as a user with a login shell. This runs .zshrc
- **``:**
- **zsh plugin standards:** https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html#_what_is_a_zsh_plugin
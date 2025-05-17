# Ansible like text blocks with bash for my dotfiles

I came up with a way for letting [bash](../660) manage block of text within text files in a similar way that [Ansible](../1020) does with `blockinfile` module. This is a trick that I use for my [dotfiles](../625).

[blockinfile]: https://docs.ansible.com/ansible/latest/collections/ansible/builtin/blockinfile_module.html

## Patch

Here's a summary of the `blockinfile` technique I'm using:

I've added a `blockinfile` function to my `lib/func.sh` script. Its purpose is to manage specific blocks of text within a file, which is super useful for integrating my dotfiles configuration without wiping out existing user settings in files like `.zshenv` or `.zshrc`.

Here's how it works:

- I call `blockinfile` with the target filename, a unique name for the block (like "zshenv" or "zshrc"), and the actual content I want in that block.
- It looks for lines like `# BEGIN block_name` and `# END block_name` in the target file. These act as markers for my managed block.
- If it finds those markers, it knows the block exists and replaces whatever is between the markers with the new content I provided. This updates my configuration section.
- If it _doesn't_ find the markers, it means the block isn't there yet. In this case, it appends the markers and my content to the end of the file.
- It also makes a backup (`.bak`) of the file before making changes, which is a nice safety net.

I'm using this in my `pkg/shell/install.sh` script to add logic to my `~/.zshenv` and `~/.zshrc`.

- For `~/.zshenv`, I use `blockinfile` with the block name `zshenv` to insert a line that sources my main Zsh environment file (`. ${PKG_ROOT}/lib/zshenv`).
- For `~/.zshrc`, I use `blockinfile` with the block name `zshrc` to insert a line that sources my main Zsh configuration file (`. ${PKG_ROOT}/lib/zshrc`).

This way, my dotfiles setup gets included in the user's shell startup files, but I don't have to worry about blowing away any custom stuff they might already have in there. It makes the installation much smoother!

Added in commit 3f3920594cac16cf7f20625699d6b3ba78bcc992 for shell version v0.1.0.

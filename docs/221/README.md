# How I use chezmoi to manage my dot files

I Use chezmoi as the only dependencies that I need to boot strap a system are already install on most systems. This includes `sh` and `curl`.

To get up and running on a new machine it is as simple as copy and pasting the below.

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:jlrickert/dotfiles.git
```

The systems that I support are as follows

- Ubuntu WSL
- Ubuntu server
- MacOSX on apple silicon

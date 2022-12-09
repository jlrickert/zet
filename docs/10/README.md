# How I manage my secret dot files using a usb stick

For managing secrets I use a thumb drive in combination with a git work tree.
How it works is lets say you have a thumbdrive mounted at
`/media/user/secrets`. I use a script called `git-secrets` that allows for
installing, and version managing. It is basically a wrapper around git using
the git worktree feature.

Here is a basic script so you get the idea

```bash
#!/usr/bin/env bash

git --git-dir=/media/user/secrets/ --work-tree=$HOME "$@"
```

This is the actual script that I am currently using. The value for DOT_SECRETS
is set at `$HOME/.env` which is parsed by my `.bashrc`.

```bash
#!/usr/bin/env bash

if [[ -z $DOT_SECRETS ]]; then
    echo "DOT_SECRETS needs to be set"
    exit 1
fi

git --git-dir=$DOT_SECRETS/ --work-tree=$HOME "$@"
```

## Creating your own

To get started with your own run the following make a repo in a directory in
your thumb drive using git. Lets say that is at `/media/jack/secrets`:

```bash
mkdir /media/jack/secrets
cd /media/jack/secrets
git init --bare
git config --local status.showUntrackedFiles no
# create an alias for for zshrc or bashrc
echo "alias git-secrets='git --git-dir=/media/jack/secrets --work-tree=$HOME'" >> ~/.bashrc
echo "alias git-secrets='git --git-dir=/media/jack/secrets --work-tree=$HOME'" >> ~/.zshrc
```

From there use the use `git-secrets` like you would with git.

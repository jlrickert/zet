# Node version managment with nvm

[nvm] is a version manager for node. I personally don't use the installer as
it trashes my dotfiles. Make sure `NVM_DIR` is
set. I do this in my `bashrc`.

Have this somewhere in your `bashrc`:

```bash
export NVM_DIR="$HOME/.local/share/nvm"
_have()      { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }
_source_if $NVM_DIR/nvm.sh
_have nvm && _source_if "$NVM_DIR/bash_completion"
```

Here is the script that I use to install it

```bash
#!/usr/bin/bash
set -e

if [[ -z "$NVM_DIR" ]]; then
    echo "NVM_DIR is not set"
    exit 1
fi

test ! -d $NVM_DIR && git clone https://github.com/nvm-sh/nvm $NVM_DIR

(
    cd $NVM_DIR
    git fetch --tags origin
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"
```

Basic cheatsheet

| command              | comment                              |
| -------------------- | ------------------------------------ |
| nvm install 16       | installs that latest 16.x.x branch   |
| nvm alias default 16 | sets the default node version to use |

[nvm]: https://github.com/nvm-sh/nvm

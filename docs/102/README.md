# Using a temporary directory that require installing transient scripts

Here is a script that I ran into that solves a problem that I often encounter:

```bash
#!/bin/sh
set -e

cd $(mktemp -d)
curl -fsSL -O https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
#export HELM_INSTALL_DIR="${HOME}/.local/bin"
bash ./get-helm-3
```

The key here is the `cd "$(mktemp -d)"`. It creates a directory and changes the
current working directory to it.

    tags: #bash

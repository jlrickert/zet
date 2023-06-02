# Install lando on MacOS

Prior to installing lando docker should be uninstalled. This is to
prevent a couple of issues.

- [ ] TODO: research the issue

Docker recommends running the following to prevent a few know issues. 

```bash
  sudo softwareupdate --install-rosetta --agree-to-license
```

Run this script

```bash
cd "$(mktemp -d)" || exit 1
curl -fsSL -O https://github.com/lando/lando/releases/download/v3.18.0/lando-arm64-v3.18.0.dmg
```

See also

- [docs](https://docs.lando.dev/getting-started/installation.html)

Meta

    tags: #programming #macOS #php

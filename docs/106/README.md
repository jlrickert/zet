# Install lando on MacOS

Prior to installing [lando] docker should be uninstalled. This is to
prevent a couple of issues. Something to note is that Docker should be
uninstalled before [lando] is installed. This allows [lando] to install
the latest version that it supports. Follow the [installation docs] for
a more detailed explanation of how to install.

Here is a quick script to get to get started. It should do most of the
work.

```bash
# only if you haven't ran this before
sudo softwareupdate --install-rosetta --agree-to-license
cd "$(mktemp -d)" || exit 1
VERSION=3.18.0
ARCH=arm64
curl -fsSL -O "https://github.com/lando/lando/releases/download/v${VERSION}/lando-${ARCH}-v${VERSION}.dmg"
sudo hdiutil attach "lando-${ARCH}-${VERSION}".dmg
# this needs to be fixed
open /Volumes/Lando\ ${VERSION}/LandoInstaller.pkg
sudo hdiutil detach "/Volumes/Lando ${VERSION}"
```

Once everything is installed x86 emutation may need to be enabled if
using apple silicon. To enable go into the settings in docker and enable
*Use Rosetta for x86/amd64 emulation on Apple Silicon*. This is found in
features in development.

An alternative installation is with brew. This is initially what I tried
but it installed a newer version of docker desktop that didn't work.
This is here for future reference.

```bash
brew install lando
```

[installation docs]: https://docs.lando.dev/getting-started/installation.html
[lando]: https://docs.lando.dev/php/

Meta

    tags: #programming #macOS #php

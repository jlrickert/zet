# How to grab a specific item in a tar file

I ran into a issue where I needed to grab a compiled item with a tar
archive using chezmoi.

It has the following structure

    ├── CHANGELOG.md
    ├── LICENSE-APACHE
    ├── LICENSE-MIT
    ├── README.md
    ├── autocomplete
    │   ├── _bat.ps1
    │   ├── bat.bash
    │   ├── bat.fish
    │   └── bat.zsh
    ├── bat
    └── bat.1

The command that I found to work to manually install

```bash
cd $(mktmp -d)
curl -fsSL -O https://github.com/sharkdp/bat/releases/download/v0.23.0/bat-v0.23.0-x86_64-apple-darwin.tar.gz
mkdir tmp
tar -xz -C tmp --strip-components 1 -f bat-v0.23.0-x86_64-apple-darwin.tar.gz
```

This will create a `tmp` directory filled with the previous dump of
contents.

    tags: #bash

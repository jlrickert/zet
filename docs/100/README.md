# Install flutter on macOS with apple silicon

Run the script to install

```bash
mkdir -p ~/.local/share
cd "$(mktemp -d)" || exit 1
curl -fsSL -O https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.10.2-stable.zip
unzip flutter_macos_arm64_3.10.2-stable.zip -d ~/.local/share
```

See also:

- [Install with curl](../101)


Meta:

    tags: #programming #macOS

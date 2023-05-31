# Install flutter on macOS with apple silicon

```bash
mkdir -p ~/.local/share
cd "$(mktemp -d)" || exit 1
curl -fsSL -O https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.10.2-stable.zip
```

| Curl option  | description |
| ------------ | ----------- |
| -f \| --fail | fail fast   |

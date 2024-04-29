# Installing software with curl

Often times packages need to be installed from the internet. Sometimes it is need to be automated. `curl` is one of the tools that may be used. This is the typical pattern that I use:

```bash
cd "$(mktemp -d)" || exit 1
curl -fsSL -O https://example.com/releases/package_macos_arm64_3.10.2-stable.zip
```

Here are the follow options that I pass in:

- `-s` or `--silent`.
- `-S` or `--show-error`
- `-f` or `--fail`. This attempts to return an error code depending on the http code.
- `-l` or `--location`. Re-attempts downloading if 3XX code is give with the new location.

This script will create a temporary directory and place the downloaded file in it. To unpack here a couple patterns that may be run.

```bash
# unzip if it is a zip folder
unzip package_macos_arm64_3.10.2-stable.zip -d /some/path

# tar
tar xf package_macos_arm64_3.10.2-stable.tar.xz
```

- [ ] TODO: figure out the tar equivalent of `unzip -d`

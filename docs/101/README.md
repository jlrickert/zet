# Installing software with curl

Often times packages need to be installed from the internet. Sometimes
it is need to be automated. `curl` is one of the tools that may be
used. This is the typical pattern that I use:

```bash
cd "$(mktemp -d)" || exit 1
curl -fsSL -O https://example.com/releases/package_macos_arm64_3.10.2-stable.zip
```

This script will create a temporary directory and place the downloaded
file in it.  To unpack here a couple patterns that may be run.

```bash
# unzip if it is a zip folder
unzip package_macos_arm64_3.10.2-stable.zip

# tar
tar xf package_macos_arm64_3.10.2-stable.tar.xz
```


    tags: #programming

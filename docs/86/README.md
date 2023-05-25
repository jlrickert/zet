# How to verify file integrity on the cli

To verify that files not been tampered with or changed an checksum
utility may be used. These could be `md5sum` or `shaXXXsum`.

Example usage:

```bash
# grab the script
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > ~/Download/rustup.sh

# calculate the checksum and place into a file
sha256sum rustup.sh > checksum

# validate the checksum
shas256 -c checksum

# validate the checksum via CLI
[[ "$(sha256sum rustup.sh)" = "be3535b3033ff5e0ecc4d589a35d3656f681332f860c5fd6684859970165ddcc" ]]
```

    #linux #security #cli #bash

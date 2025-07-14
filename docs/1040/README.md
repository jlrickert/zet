# Installing CSS compressor csso with deno

I found a way to install npm binaries with deno. One caveat of this is the large binary size. Uglify has a size of 66M.

This is the process of installing that I used:

```bash
deno compile -A npm:csso-cli
chmod +x csso-cli
mv csso-cli ~/.local/bin/csso
```

# Installing JavaScript minifier uglify with deno

I found a way to install npm binaries with deno. One caveat of this is the large binary size. Uglify has a size of 66M.

This is the process of installing that I used:

```bash
deno compile -A npm:uglify-js
chmod +x uglify-js
mv uglify-js ~/.local/bin/uglify
```

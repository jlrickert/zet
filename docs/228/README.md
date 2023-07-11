# pnpm mono repo strategy

By default all dependencies from packages are _hoisted_ up and available at the
root.

```yaml
# in pnpm-workspace
packages:
  - "packages/*"
  - "plugins/accordion"
```

Run all the things

```bash
pnpm run -r start
```

`-r` does all the magic.

If you also want to include the root `package.json` start script then add the
following to `.npmrc` file

```
ignore-workspace-root = true
```

    tags: #webdev

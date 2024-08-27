# A custom publish function for changeset

Experimenting with creating versioned packages for my [dotfiles](../625) using [changeset](../814).

```yaml
name: Release

on:
  push:
    branches:
      - main

concurrency: ${{ github.workflow }}-${{ github.ref }}

jobs:
  release:
    name: Release
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repo
        uses: actions/checkout@v4

      - uses: pnpm/action-setup@v4
        with:
          version: 9
          run_install: false

      - name: Setup Node.js 20.x
        uses: actions/setup-node@v4
        with:
          node-version: 20.x
          cache: "pnpm"

      - name: Install dependencies
        run: pnpm install

      - name: Create Release Pull Request or Publish to npm
        id: changesets
        uses: changesets/action@v1
        with:
          # This expects you to have a script called release which does a build
          # for your packages and calls changeset publish
          version: pnpm run version-packages
          # publish: pnpm run publish
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

      - name: Publish
        if: steps.changesets.outputs.hasChangesets == 'false'
        # You can do something when a publish should happen.
        run: node ./lib/publish.mjs {{ }}
```

Shape of output of `steps.changesets.outputs`:

```yaml
published:
  description: A boolean value to indicate whether a publishing is happened or not
publishedPackages:
  description: >
    A JSON array to present the published packages. The format is `[{"name": "@xx/xx", "version": "1.2.0"}, {"name": "@xx/xy", "version": "0.8.9"}]`


hasChangesets:
  description: A boolean about whether there were changesets. Useful if you want to create your own publishing functionality.
pullRequestNumber:
  description: The pull request number that was created or updated
```

See <https://github.com/changesets/action/blob/main/action.yml> for a complete list.

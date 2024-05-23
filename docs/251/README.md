# How to setup automated change logs with github actions

This is still a proof of concept. On issue with this method is that the bot likes to commit to the main branch. For small projects this adds extra complexity as you have to deal with the merging with a remote repo.

There are 2 ways that I have found. One is with `semantic release` and the other is with `commitlint`. `commitlint` seems to have the

Install the required packages

```bash
pnpm add --save-dev @semantic-release/changelog @semantic-release/git semantic-release
```

Add the following semantic release configuration to `.releaserc.json`

```json
{
  "branches": [
    "+([0-9])?(.{+([0-9]),x}).x",
    "main",
    {
      "name": "beta",
      "prerelease": true
    },
    {
      "name": "alpha",
      "prerelease": true
    }
  ],
  "plugins": [
    "@semantic-release/commit-analyzer",
    "@semantic-release/release-notes-generator",
    [
      "@semantic-release/changelog",
      {
        "changelogFile": "CHANGELOG.md"
      }
    ],
    [
      "@semantic-release/git",
      {
        "assets": ["CHANGELOG.md"],
        "message": "chore(release): ${nextRelease.version} [skip ci]\n\n${nextRelease.notes}"
      }
    ]
  ]
}
```

Github action. Add the following contents to the file `.github/workflows/release.yml`

```yaml
name: Release
on:
  push:
    branches:
      - "main"

permissions:
  contents: read # for checkout

jobs:
  release:
    name: Release
    runs-on: ubuntu-latest
    permissions:
      contents: write # to be able to publish a GitHub release
      issues: write # to be able to comment on released issues
      pull-requests: write # to be able to comment on released pull requests
      id-token: write # to enable use of OIDC for npm provenance
    steps:
      - name: Checkout
        uses: actions/checkout@v3
        with:
          fetch-depth: 0
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: "lts/*"

      - name: Install pnpm
        run: npm install --global pnpm
      - name: Install dependencies
        run: pnpm install
      - name: Verify the integrity of provenance attestations and registry signatures for installed dependencies
        run: pnpm audit signatures
      - name: Release
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
        run: pnpx semantic-release
```

## See also

- [Changelog automation in python](../381)

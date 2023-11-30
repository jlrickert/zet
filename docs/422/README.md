# Proof of concept for a monorepo with changesets

The goal is to create a mono repo with a CI/CD pipeline that automates
publishing packages to npmjs. The tools that I am using to accomplish this
include:

- turborepo
- pnpm
- changesets

Here are some packages that I would like to publish to npmjs:

- @jlrickert/eslint-config-custom

  This is my custom eslint config

- @jlrickert/react-UI

  My own personal UI framework

- @jlrickert/tsconfig

  Base config for things. Probably not useful. Useful for experimenting.

## General workflow

- make branch off of the dev branch. Typically this is either a feature, fix, or
  release branch but not always.
- make changes to branch
- add changeset once

## Building

## Testing

## Deployment

## See also

- https://github.com/vercel/turbo/tree/main/examples/with-changesets
- https://github.com/vercel/turbo/tree/main/examples/kitchen-sink

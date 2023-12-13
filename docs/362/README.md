# Simple versioning using changesets

What I consider a successful release consists of the following:

- A feature set

  This includes a feature set of something that impacts end users. This may
  include new features, performance enhancements, and/or bug fixes.

- A change log update that documents what has changed to the end user.
  Typically, this will be tied to a version.

- Packages are built and released.

The typical workflow is make a couple of commits to git using
[conventional commits](https://www.conventionalcommits.org/en/v1.0.0/). Once you
are satisfied typically I would make a bunch of changesets.

## Setup

Run the following in the root of the project. May need to use the
`--workspace-root`.

```bash
pnpm add -D @changesets/cli
pnpm exec changeset init
```

## Updating versions

WIP

```
pnpm exec changeset version
```

## See also

- https://github.com/changesets/changesets/tree/main

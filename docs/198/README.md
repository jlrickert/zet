# How to manage dependencies with git submodules

## How to add

```bash
git submodule add $GIT_URL $DEP_PATH
```

This will add an entry in `.gitmodules`, `.git/config`, and `.git/modules`. This then needs to be committed in git.

## How to install

To install the submodules run the following:

```bash
git submodule init
git submodule update
```

Alternatively this can be done when first cloning.

```bash
git clone $PROJECT_URL --recursive
```

## How to move

TODO: clean up and verify this process

- Update submodules in `.gitsubmodule`
- Update submodules in `.git/config`
- Remove submodule in `.git/modules/`
- Commit stuff in git

## How to update

Update submodules in `.git/config`

## Key commands

| Git sub command | Comment          |
| --------------- | ---------------- |
| add             | add a dependency |
| update          |                  |
| init            |                  |

    tags: #webdev

# Releasing software with python

This whay I define as a release

- An updated changed log with changes based on conventional commits
- The version bumped to the semvar version where appropriate
- A git repo with a tag set to the semvar version
- typically the main repo will be set the the latest semvar repository
- the new tag branch should have its packages deployed where ever

CHANGELOG is the file that tells you what has changed for each version number
based conventional commits.

The tools that I am using is pre-commit and poetry

```bash
brew install poetry
poetry init
vim .pre-commit-config.yaml
pnpm i -g release-please
pre-commit install
```

The contents of the `.pre-commit-config.yaml`

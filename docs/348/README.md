# Deploying a keg on MkDocs

The quickest way to get started is with docker.

Create a **Dockerfile** with the following contents

```Dockerfile
FROM python:alpine3.18

RUN apk upgrade --update-cache -a && \
    apk add --no-cache git git-fast-import openssh

RUN pip install mkdocs
RUN pip install mkdocs-meta-manager
RUN pip install markdown-checklist

RUN git config --global --add safe.directory /docs &&\
    git config --global --add safe.directory /site

WORKDIR /docs
EXPOSE 8000

ENTRYPOINT ["mkdocs"]
```

Create a file **install** with the following content:

```bash
#!/usr/bin/env bash

docker build -t zet-mkdocs .
```

Create a **mkdocs** file with the following content:

```bash
docker run --rm -it -p 8000:8000 -v "${PWD}:/docs" zet-mkdocs "$@"
```

Make sure that they are both executable.

```bash
chmod +x ./install ./mkdocs
```

A a **mkdocs.yaml** file needs to exist. Here is an example from what I am
currently using.

```yaml
site_name: KEG Zettelkasten for Jared Rickert (jlrickert)
site_url: https://zet.jlrickert.me
repo_name: jlrickert/zet
repo_url: https://github.com/jlrickert/zet
edit_uri: edit/main/docs
site_author: Jared Rickert (jaredrickert52@gmail.com)
site_description: >-
  Hi I'm Jared. This is my personal **zettelkasten** KEG site. It contains stuff
  on pretty much any topic I feel like writing about, mostly about [baking](292)
  and tech how too. You can think of it as my own personal stack overflow or
  arch wiki. The latest additions and changes are always [indexed](dex).

  A word of caution is that these are raw notes. They may be inaccurate, messy,
  and/or plain misleading. Please don't quote me here as I may not still hold
  the same opinion on the subject. That is what my [blog] is for.

  The reason that I make these notes available is that they may be helpful to
  some one out there.
use_directory_urls: false
theme:
  name: readthedocs
  analytics:
    gtag: G-WXQ3PHET4N
  titles_only: true
  highlightjs: true
  hljs_languages:
    - TypeScript
    - Svelte
    - Shell
    - SCSS
    - SAS
    - Rust
    - Ruby
    - R
    - Python
    - PostgreSQL
    - JavaScript
    - Go
    - Java
    - JSON
    - TOML
    - hlsl
    - Haskell
    - HTTP
    - GraphQL
    - Dockerfile
    - DNS Zone file
    - Django
    - Diff
    - Dart
    - CSS
    - CMake
    - C
    - C++
    - Bash
    - Awk
extra:
  consent:
    title: Cookie consent
    description: >-
      We use cookies to recognize your repeated visits and preferences, as well
      as to measure the effectiveness of our documentation and whether users
      find what they're searching for. With your consent, you're helping us to
      make our documentation better.
plugins:
  - search
  - meta-manager:
      meta_filename: meta.yaml

markdown_extensions:
  - footnotes
  - fenced_code
  - tables
  - admonition
  - sane_lists
  - smarty
  - markdown_checklist.extension
```

Run `./mkdocs serve -a 0.0.0.0:8000`

## Deploying to GitHub pages

Create the file **.github/workflows/ci.yml** with the following contents:

```yaml
name: ci
on:
  push:
    branches:
      - main
permissions:
  contents: write
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v4
        with:
          python-version: 3.x
      - run: echo "cache_id=$(date --utc '+%V')" >> $GITHUB_ENV
      - uses: actions/cache@v3
        with:
          key: mkdocs${{ env.cache_id }}
          path: .cache
          restore-keys: |
            mkdocs-
      - run: pip install mkdocs
      - run: pip install mkdocs-meta-manager
      - run: pip install markdown-checklist
      - run: mkdocs gh-deploy --force
```

## See also

- [mkdocs material]:
    https://squidfunk.github.io/mkdocs-material/setup/setting-up-site-search/

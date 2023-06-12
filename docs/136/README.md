# How to setup VSCode for PHP and WordPress development

VSCode is a decent IDE for WordPress development. Currently, I am using
intelphense for a language server. It is missing some key features that
I would like as I am using the free version. Phpactor seems like It
might be a free option that does everything that is needed but doesn't
look like it is available.

Here are the steps to setup

Add some where to the stubs in `.vscode/settings.json` for either the
current workspace or globally.

```json
    "intelephense.stubs": [
        "wordpress"
        ...
    ]
```

- [ ] TODO: move stuff here from other places

- 134
- 132

Meta

    tags: #wordpress #php #development

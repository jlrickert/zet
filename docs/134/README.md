# Recommended php language server to use

The 3 choices of language servers for PHP are as follows:
[intelephense], [phpactor], [psalm], and [devsense]. Neovim has the
option of running all but [devsense]. VSCode really only has 2 choices,
[intelephense] and [devsense].

Intelephense is not open source. The o

| LSP            | Open source | Comments                                    |
| -------------- | ----------- | ------------------------------------------- |
| [intelephense] | no          |                                             |
| [phpactor]     | yes         |                                             |
| [psalm]        | yes         | is this old?                                |
| [devsense]     | no          |                                             |
|                |             | Deprecated. Can't remember name. Don't care |

I found the available php servers from the mason [lspconfig] extension's
list of available servers.

Visual studio has another popular plugin simply named _PHP_ from [devsense]

Visual studio plugins

Recommended Visual studio plugins

- PHP [intelephense]
- PHP Debug
- WordPress snippet

Comparison

| Feature                 | psalm | phpactor | intelephense |
| ----------------------- | ----- | -------- | ------------ |
| Code completion         |       | x        | x            |
| search symbol           |       |          | x            |
| signature help          |       | x        | x            |
| diagnostics             |       |          | x            |
| formatting              |       |          | x            |
| rename                  |       | x        | x            |
| highlighting            |       |          | x            |
| html/css/js integration |       |          | x            |
| code folding            |       |          | paid         |
| go to type def          |       |          | paid         |
| go to declaration       |       |          | paid         |
| code actions            |       |          | paid         |

For WordPress stuff use WordPress snippet
PHP Debug

[phpactor]: https://phpactor.readthedocs.io/en/master/
[psalm]: https://psalm.dev/
[intelephense]: https://intelephense.com/
[devsense]: https://www.devsense.com/en
[lspconfig]: https://github.com/williamboman/mason-lspconfig.nvim/blob/5230617372e656d4a2e1e236e03bf7e7b4b97273/README.md#available-lsp-servers

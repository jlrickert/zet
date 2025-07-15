# PHP setup for Neovim

My PHP related things to [Neovim](../625).

## [Diagnostic](../1045)

- `phpstan`

## [Formatter](../1037) setup

- pretty-php

```lua
local confg = {
  opts = {
    formatters_by_ft = {
      opts = {
        php = { 'pretty_php' },
      }
      formatters = {
        pretty_php = function()
          return {
            meta = {
              url = 'https://github.com/lkrms/pretty-php',
              description = 'The opinionated PHP code formatter.',
            },
            command = require('conform.util').find_executable({
              'vendor/bin/pretty-php',
            }, 'pretty-php'),
            args = { '$FILENAME', '--tab' },
            stdin = false,
          }
        end,
      },
    }
  },
}
```

## [Language Server Protocol (LSP)](../1052)

- `intelephense`

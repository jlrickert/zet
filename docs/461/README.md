# Snippets in neovim

Currently, I am using [Luasnip] for the snippet engine.

Here is the relevant code to loading snippets. You can find it in the **autopairs_and_cmp.lua** file in my nvim config found in my [dotfiles].

[dotfiles](https://github.com/jlrickert/dotfiles)

```lua
-- Load snippets
local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
```

This loads the snippets in the directory **~/.config/nvim/snippets**. See the snippets example in honza's vim-snippets project on github for an example for what goes in there.

[Luasnip](https://github.com/L3MON4D3/LuaSnip)

## Date and time formats

If using snipmate use `strftime` which is a vimscript function. See https://renenyffenegger.ch/notes/development/vim/script/vimscript/functions/strftime for formatting.

## See also

- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [examples](https://github.com/honza/vim-snippets)
# File type specific settings in neovim

Here is an example of the thing

```lua
augroup markdownSpell
    autocmd!
    autocmd FileType markdown setlocal spell
    autocmd BufRead,BufNewFile *.md setlocal spell
augroup END

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local markdownSpell = augroup('markdownSpell', {})
autocmd({'BufRead', 'BufNewFile'}, {
    pattern = '*.md',
    group = markdownSpell,
    callback = function ()
        vim.opt_local.spell = true
    end
})
```

Tags:

    #neovim

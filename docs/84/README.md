# My preferred way of handling text width in documents

Currently, I like having each line of text to be around rough 72
characters long. I have something like the following on my nvim
configuration.

```lua
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'gitcommit', 'NeogitCommitMessage', 'text', 'markdown', 'text' },
    group = text_group,
    callback = function()
        -- enough for line number + gutter within 80 standard
        vim.opt_local.textwidth = 72
    end,
})
```

    #vim #neovim #linux #cli

# Diagnostics in neovim

## Hotkeys

```lua
vim.keymap.set('n', 'gl', function()
	vim.diagnostic.open_float({ border = 'rounded' })
end, { desc = 'Show diagnostic details in float' })
```
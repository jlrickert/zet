# Neovim file explorers

[Neotree] is the go to plugin for a file explorer in [neovim](../619) that I use for my [dotfiles](../625).

[Neotree]: https://github.com/nvim-neo-tree/neo-tree.nvim

## Patches

### Hotkeys

```lua
-- File explorer
vim.keymap.set('n', '<leader>e', function()
	require('neo-tree.command').execute({ toggle = true, dir = vim.fn.getcwd() })
end, { desc = '[E]xplore files' })
```

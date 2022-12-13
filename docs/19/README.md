# Package managment in neovim with mason

Mason is a package manager for neovim. The contents of the packages that may be
installed are DAP, LSP, Linters and formatters. To quickly setup do the
following:

```lua
-- put this somewhere in your packer file
use { "williamboman/mason.nvim" }

-- setup the thing
require("mason").setup()
require("mason-lspconfig").setup({
})
```

See [mason] and [mason-lspconfig] for more details.

[mason]: https://github.com/williamboman/mason.nvim
[mason-lspconfig]: https://github.com/williamboman/mason-lspconfig.nvim

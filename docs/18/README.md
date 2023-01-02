# Quick start on settup lsp for neovim lua hacking

Having a working language server while working with neovim lua is a massive
productivity boost. To setup the `lua-language-server` needs to be installed. I
am currently using [mason](../0) to install and manage this installation.

This is the minimum I have found that works.

Include `use("neovim/nvim-lspconfig")` some where in your packer file. The
follow configure sumneko_lua:

```lua
require("lspconfig")["sumneko_lua"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJUT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostic = {
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
```

I have also found [lsp-zero]. This aims to be a zero config for people who
don't want to fuck around configuring shit.

[lsp-zero]: https://github.com/VonHeikemen/lsp-zero.nvim

Tags:

    #neovim

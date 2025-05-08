# Resources for rebuilding my neovim setup

I am at a point where I need to do a near complete rebuild of my [Neovim setup](../619) as there are breaking changes in the 0.11 version and that a lot of my plugins are blasting me with warnings and has been causing issues.

- [Kickstart](https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua)

  Shows the basics of whats needed. Has an example of the newer plugins that should be used

- [Primeagen](https://github.com/ThePrimeagen/init.lua)

  [He](../1006) has a good setup for himself. Good place to steal things from

## Planned plugins

- Completion's with [blink]

  This replaces the auto complete plugin [nvim-cmp] that I am using currently. Looks like it is significantly better. This needs rust, git, and curl to function.

- Status line with [lualine]

[blink]: https://github.com/Saghen/blink.cmp
[lualine]: https://github.com/nvim-lualine/lualine.nvim
[nvim-cmp]: https://github.com/hrsh7th/nvim-cmp

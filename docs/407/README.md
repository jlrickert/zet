# Neovim intellisense for json files

I haven't yet figured out how to get intellisense to work in neovim for some
specific files. What I have found is that you can manually add a `$schema`
property to add intellisense. These may be looked up on
https://www.schemastore.org/json/. It may also be possible to use them for yaml
as well.

Here are some of the more useful ones

| Package      | Schema url                                   |
| ------------ | -------------------------------------------- |
| package.json | https://json.schemastore.org/package.json    |
| .prettierrc  | https://json.schemastore.org/prettierrc.json |

    tags: #noevim

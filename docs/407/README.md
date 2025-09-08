# Neovim intellisense for JSON files

I haven't yet figured out how to get intellisense to work in neovim for some
specific files. What I have found is that you can manually add a `$schema`
property to add intellisense. These may be looked up on
<https://www.schemastore.org/>. It may also be possible to use them for yaml as
well.

Here are some of the more useful ones

| Package      | Schema url                                                                                 |
| ------------ | ------------------------------------------------------------------------------------------ |
| package.json | <https://json.schemastore.org/package.json>                                                |
| .prettierrc  | <https://json.schemastore.org/prettierrc.json>                                             |
| changeset    | <https://raw.githubusercontent.com/changesets/changesets/main/packages/config/schema.json> |

## Overview

This document explains how JSON and YAML "IntelliSense" (schema-driven
validation, completions, hover, diagnostics) is configured in your Neovim setup.
It highlights the plugins and LSP settings used and shows how to extend or
troubleshoot the configuration.

## Components involved

- nvim-lspconfig — configures language servers (jsonls, yamlls).
- mason / mason-lspconfig / mason-tool-installer — manage installation and
  registration of LSP servers.
- b0o/schemastore.nvim — provides a catalog of JSON and YAML schemas
  (SchemaStore).
- blink.cmp — supplies enhanced LSP capabilities for completion (capabilities
  merged into servers).
- jsonls (JSON Language Server) and yamlls (YAML Language Server) — actual
  servers providing schema-based features.

## How the pieces connect (high level)

1. schemastore.nvim exposes helper functions that return schema lists/tables for
   JSON and YAML.
2. jsonls and yamlls are configured via nvim-lspconfig to use the
   schemastore-provided schemas.
3. Mason ensures LSP binaries are installed; mason-lspconfig registers handlers
   which set up the servers with capabilities and the provided settings.
4. The servers then use the schemas to provide validation, completion, hover and
   diagnostics based on file name/content.

## jsonls setup (what the config does)

The config merges schemastore's JSON schema list with any custom schema entries
and enables validation. This allows jsonls to pick the correct schema for known
filenames (package.json, tsconfig.json, etc.) or for files that specify a
$schema.

Example from your config:

```lua
jsonls = {
  settings = {
    json = {
      schemas = vim.list_extend(
        require('schemastore').json.schemas(),
        {
          {
            fileMatch = { 'deno.json', 'deno.jsonc' },
            url = 'https://raw.githubusercontent.com/denoland/deno/main/cli/schemas/config-file.v1.json',
          },
        }
      ),
      validate = { enable = true },
    },
  },
},
```

## yamlls setup (what the config does)

yamlls has built-in SchemaStore support but the config disables the built-in
store and injects schemastore.nvim's YAML schemas instead. That avoids conflicts
and lets you control which schema catalog is used.

Example from your config:

```lua
yamlls = {
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = '',
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
},
```

## How schemastore.nvim works

- require('schemastore').json.schemas() returns a list (array) of schema entries
  for jsonls. Each entry typically contains url and fileMatch (patterns).
- require('schemastore').yaml.schemas() returns a mapping suitable for yamlls
  (usually url → fileMatch array).
- These helpers are simply Lua tables you pass to LSP configuration. The servers
  consume them to match a schema to a file.

## Adding custom JSON schemas

Example: append a custom schema for "myapp.config.json":

```lua
local schemas = require('schemastore').json.schemas()
table.insert(schemas, {
  fileMatch = { 'myapp.config.json', 'myapp.*.json' },
  url = 'https://example.com/schemas/myapp.config.schema.json',
})
-- then set jsonls.settings.json.schemas = schemas in your jsonls config
```

Notes:

- jsonls accepts an array of schema objects with fileMatch/url.
- Files that include a "$schema" property will be matched to that URL (jsonls
  honors $schema).

## Adding custom YAML schemas

yamlls expects a mapping of schemaURL → fileMatch array. Example:

```lua
local yaml_schemas = require('schemastore').yaml.schemas()
yaml_schemas['https://example.com/schemas/myapp.yaml'] = { 'myapp*.yml', 'myapp.yaml' }
-- then set yamlls.settings.yaml.schemas = yaml_schemas in your yamlls config
```

Notes:

- Order/priority: yamlls chooses a schema by pattern match; explicit
  $schema-like hints (document-specific anchors) help too.
- Make sure schemaStore.enable = false is present if you're replacing the
  built-in store.

## Using local schema files

- jsonls: use a file:/// URL to point to an absolute local schema path, e.g.
  "file:///home/me/schemas/myschema.json".
- yamlls: use the file:/// URL as the key in the yamlls schemas mapping, e.g.:

```lua
yaml_schemas['file:///home/me/schemas/myyaml.schema.yaml'] = { 'myproject/*.yml' }
```

Be careful with escaping and absolute paths — LSP servers expect proper URIs.

## Troubleshooting steps

1. Is the LSP running for the buffer?
   - In Neovim: :LspInfo — check if jsonls or yamlls is attached to the buffer.
2. Are the servers installed?
   - Run :Mason and check jsonls / yamlls. The config uses mason-tool-installer
     to ensure installed servers.
3. Are the schemas present?
   - In Lua: :lua print(vim.inspect(require('schemastore').json.schemas())) (or
     yaml.schemas()) to ensure the catalog returns data.
4. Is your file matched by fileMatch?
   - Many schemas only match specific filenames (package.json, tsconfig.json,
     .eslintrc.json, docker-compose.yml). Rename or add mapping if needed.
5. LSP logs:
   - Check lsp logs (path varies by Neovim version). Print
     vim.lsp.get_log_path() if available or check ~/.local/state/nvim/\* logs.

## Useful commands and checks

- :LspInfo — see active LSP clients and attached servers for current buffer.
- :Mason — check/install servers used by mason.
- :lua print(vim.inspect(require('schemastore').json.schemas())) — dump JSON
  schema list.
- :lua print(vim.inspect(require('schemastore').yaml.schemas())) — dump YAML
  schema mapping.
- :checkhealth — general diagnostics.

## Notes & tips

- $schema in JSON files overrides filename matching; you can set $schema to a
  schema URL to force a schema.
- For YAML, mapping schema URL → file patterns is the usual approach.
- Keep schemastore merged with custom entries rather than replacing it entirely
  — you get both the community catalog and your overrides.
- If completion / hover seems limited, ensure blink.cmp capabilities are merged
  into the server (your config uses
  require('blink.cmp').get_lsp_capabilities()).

If you want, I can produce:

- A small patch snippet to add a local schema mapping to your
  lua/kickstart/plugins/lspconfig.lua.
- A short list of common schema fileMatch patterns (package.json, tsconfig.json,
  docker-compose.yml, .github/workflows/\*.yml) to add if you need them.

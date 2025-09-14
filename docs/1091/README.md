# Github MCP setup

An [MCP](../1090) server for [GitHub](../1092). See the [project] on GitHub.

I have setup this up with [mods](../916) using the cli from brew.

[project]: https://github.com/github/github-mcp-server

## Installation

```bash
brew install github-mcp-server
```

## Token setup

Add token to `~/.local/share/dotfiles/secrets/personal.sh`

## Testing example

```bash
github-mcp-server stdio <<EOF
{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"test","version":"1.0"}}}
{"jsonrpc":"2.0","id":2,"method":"tools/call","params":{"name":"search_repositories","arguments":{"query":"user:jlrickert"}}}
EOF
```

## Claude desktop application

Config is located at `~/Library/Application Support/Claude/claude_desktop_config.json`

```json
{
  "mcpServers": {
    "github": {
      "command": "github-mcp-server",
      "args": ["stdio", "--read-only"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "github_pat_xxxxyyyyzzzz"
      }
    }
  }
}
```
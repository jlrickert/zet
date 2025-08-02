# Project: `mods` by Charmbracelets

The `mods` command is a powerful tool developed by Charmbracelets for managing interactions with language models, particularly from OpenAI. It simplifies the process of creating, continuing, and customizing AI-driven conversations while providing users with flexibility in model selection.

### High-Level Details:

- **Model Management**: Easily switch and specify which AI model to use.
- **Session Control**: Start new sessions or continue existing conversations based on user-defined titles.
- **Flexible Input Handling**: Supports inputs from various sources, enhancing integration capabilities.
- **Customizable Operations**: Pass additional parameters to refine interactions based on project needs.

For detailed documentation and further information, please visit the [mods GitHub repository]

[mods GitHub repository](https://github.com/charmbracelet/mods).

## MCP

```yaml
mcp-servers:
  # Example: GitHub MCP via Docker:
  # github:
  #   command: docker
  #   env:
  #     - GITHUB_PERSONAL_ACCESS_TOKEN=xxxyyy
  #   args:
  #     - run
  #     - "-i"
  #     - "--rm"
  #     - "-e"
  #     - GITHUB_PERSONAL_ACCESS_TOKEN
  #     - "ghcr.io/github/github-mcp-server"
# {{ index .Help "mcp-timeout" }}
```

This is what I have so far

```yaml
mcp-servers:
  github:
    command: github-mcp-server
    args:
      - "stdio"
      - "--read-only"
```

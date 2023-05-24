# Harpoon keybindings in vscode

Settings for the VSCode Harpoon plugin. This is just a dump of the suggested
keybindings for my reference.

VScode

```jsonc
  {
    "key": "alt+a",
    "commands": ["vscode-harpoon.addEditor"]
  },
  {
    "key": "alt+e",
    "commands": ["vscode-harpoon.editEditors"]
  },
  {
    "key": "alt+p",
    "commands": ["vscode-harpoon.editorQuickPick"]
  },
  {
    "key": "alt+1",
    "command": "vscode-harpoon.gotoEditor1"
  }
```

```jsonc
// settings.json
{
  "vim.leader": " ",
  "vim.normalModeKeyBindings": [
    {
      "before": ["<leader>", "a"],
      "commands": ["vscode-harpoon.addEditor"]
    },
    {
      "before": ["<leader>", "e"],
      "commands": ["vscode-harpoon.editEditors"]
    },
    {
      "before": ["<leader>", "p", "e"],
      "commands": ["vscode-harpoon.editorQuickPick"]
    },
    {
      "before": ["<leader>", "1"],
      "commands": ["vscode-harpoon.gotoEditor1"]
    }
  ]
}
```

    #workstation #vscode #programming

# Automatically rerunning commands with `entr`

`entr` is a unix filter for rerunning commands.

## One liners

This is a couple of one liners that I have found to be helpful.

Rerun bash script when anything in the current working directory changes

```bash
find . | entr -s bash ''
```

For updating the server on file change use `-r`

```bash
find . | entr -r python server.py
```

Compile a chezmoi template to see what it looks like.

```bash
find . | entr -s 'chezmoi execute-template "$(cat home/run_onchange_before_10_packages.tmpl)" -o /tmp/compiled_template.sh'
```

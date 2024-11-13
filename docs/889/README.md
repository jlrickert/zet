# SPEC: nexi bash script

A bash script for training an AI against my [kegs](../887) and to interact with a chat bot that has knowledge of its contents.

```bash
CONFIG_FILE="${HOME}/.config/knut/config.yaml"
```

A list of available kegs may be found with:

```bash
KEGS="$(yq ".kegs[] | .alias" "${CONFIG_FILE}")"
cmd="$(printf "%s" "${COMP_LINE}" | awk '{print $2}')"
```

## CLI examples

### `nexi train personal 54`

```bash
nexi train personal 54
```

### `nexi log personal edit`

Opens up a log to what nodes have been trained. This is more for debugging. Logs will be in `${HOME}/.local/state/nexi/personal.json`. `personal` is the name of the keg.

## Training script

```bash
# feed all nodes from keg keg-spec to the AI
zet pub cat 887 | mods --role keg "This is the contents of node pub/887"
zet pub cat 889 | mods --role keg -C "This is the contents of node pub/889"
cat "$(command -v ecw)" | mods --role keg -C "This is the content of a script that I wrote.  I would like nexi to be in the same coding style."
```

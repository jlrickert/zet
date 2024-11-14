# Enabling vi mode editing in bash

`vi` mode in bash lets you navigate the current line using the `vi` based keybindings that you already know.

![example](./recording.mov)

To enable add the following to your `.bashrc`

```bash
set -o vi
```

By default you will be in **insert** mode. To enable navigation **normal** mode needs be enabled. This may be hitting the escape key.

Another trick is to enter visual mode. In **normal** mode hit v. This will open up the current line in "${EDITOR}" (vim by default I think - not verified). Edit like a normal bash script. Enter **normal** mode and type `:wq`. By default I think the script will auto run. If not hit enter.

## Cheat sheet

- Entering **normal** mode:

  Spam ESCAPE key

- Entering **insert** mode

  Hit either `i` or `a`. `i`

- Entering **visual** mode (editing the line as a bash script instead of a long line)

  In **normal** mode hit `v`

- Navigation

  In **normal** mode use `h` (left) and `l` (right)

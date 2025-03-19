# App: skhd - a simple hotkey daemon for macOS

A [macOSX](../654) hotkey daemon that I use on my [mac](../583). Works well with [Yabai](../103).

## Common issues

### `skhd` refuses to run when starting service.

I had to remove the `skhd` from the list of accessibility items and rerun `skhd --start-service` on the command line. Then accept the popup

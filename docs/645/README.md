# My current zettelkasten note taking setup

This is an evolving setup. I use a combination of [neovim](../619), [knut](../609) and [keg](../646).

## Configuration

Configuration in `~/.config/knut/config.yaml`. This holds the locations for all of my kegs. I then use `yq` to query the information needed for other scripts.

## Programs

### Neovim

This what what I use to edit the files. I use telescope's built in search features. Word search and grep search for find content. [Telescope](../647) file finder if I already know the node number.

### Knut

I use this for searching against all kegs for content. At some point I want to centralize a lot of the functionality to here

### keg

### zet

I use `zet` as way to select the keg that I want to work against with.

`zet` gets the location using `KEGS="$(yq ".kegs[] | .alias" "${HOME}/.config/knut/config.yaml")"`.

### ku

`ku` is just a wrapper around keg and adds a few extra commands.

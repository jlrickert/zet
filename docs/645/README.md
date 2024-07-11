# My current zettelkasten note taking setup

This is the setup and tooling that I use

This is an evolving setup and is still quite unstable. I use a combination of [neovim](../619), [knut](../609), [keg](../646) and a bunch of custom scripts.

The reason for building my own system is because I needed a system where I could didn't have to fight the system for capturing things and later being able to find them later. Things like notion and obsidian are problematic because I always fight with the wysiwyg. There also lock you into there platform. Obsidian does a bunch of custom stuff that makes syncing a bigger PITA than it should.

## Programs and dependencies

- bat
- dotfiles
- fd-find
- fzf
- knut
- mods
- neovim
- prettier
- ripgrep
- yq
- zellij

### Command and software

#### Neovim

My main editor. I use telescope's built in search features. Word search and grep search for finding content. [Telescope](../647) file finder if I already know the node number.

#### Knut

I use this for searching against all kegs for content. At some point I want to centralize a lot of the functionality to here. Eventually, zet and keg will be a part of this.

Configuration in `~/.config/knut/config.yaml`. This holds the locations for all of my kegs. I then use `yq` to query the information needed for other scripts.

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/jlrickert/knutjs/main/packages/knut-core/knutSchema.json
format: yaml
version: draft-0.1
plugins:
  - name: date
    enabled: true
kegs:
  - url: ~/repos/github.com/jlrickert/zet/docs
    alias: pub
  - url: ~/repos/github.com/jlrickert/br8kthru-zet/docs
    alias: br8kthru
  - url: ~/repos/github.com/jlrickert/zettel/docs
    alias: priv
  - url: ../../repos/github.com/rwxrob/zet/docs
    alias: rwxrob
  - url: ../../repos/bitbucket.org/jared52/zet/docs
    alias: ecw
```

To install run `npm i -g @jlrickert/knutjs-cli@0.4.1`

At the time of writing this knut is a mess as I am doing a lot of refactoring. Just did a lot of experiments to see what works and what doesn't.

#### keg

I use a modified [keg](../646) program. To install run `go install github.com/jlrickert/keg/cmd/keg@latest`.

#### zet

I use `zet` as way to select the keg that I want to work against with.

`zet` gets the location using the command `KEGS="$(yq ".kegs[] | .alias" "${HOME}/.config/knut/config.yaml")"`.

#### zets

I use to use it before I figured out Telescope. I need may need to go back to this as it may offer an opportunity to use callbacks between operations on my keg.

#### mods

ChatGPT on the CLI. I can pipe my node entries to it to feed it information about a topic. It is vim filter compatible for doing a bunch of fancy stuff like rewriting sections of code.

#### zellij

A better tmux. Still a bit buggy but good enough. I keep my keybindings as close as possible to tmux. Sticking with the defaults I find is better over the long run. I need to have some sort of tiling manager as I often need to have a couple nodes up.

## Publishing

Have not found a good solution yet as everything I find assumes the name of the file is the title. Checkout <https://jlrickert.github.io/zet/index.html>. This is a proof of concept using mkdocs.

## Future plans

- Look into switching to either asciidoc or emacs org mode

  Markdown is a mess of a standard and I would like more power

- Replace keg with my own that I can control. This will be part of knut
- Rebuild everything around a new standard rather than keg-spec

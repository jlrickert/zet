# Managing ruby version on MacOSX with chruby

Quickly get ruby 3.2.2 installed.

```bash
brew install chruby ruby-install xz
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
ruby-install 3.2.2 # I would run ruby-install first and get the latest version
chruby ruby-3.2.2  # Use same installed version
```

Put this somewhere in your zshrc.

```bash
_source_if() { [[ -r "$1" ]] && source "$1"; }
_source_if /opt/homebrew/opt/chruby/share/chruby/chruby.sh
_source_if /opt/homebrew/opt/chruby/share/chruby/auto.sh
```

I use a chezmoi template adding this to my zshrc file for me.

## Meta

    tags: #macosx #ruby

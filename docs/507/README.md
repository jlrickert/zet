# Knut installation process on MacOSX

## Dependencies

- node and npm

  ```
  brew install fnm
  fnm install --lts
  ```

  Some where in your _~/.bashrc_ or _~/.zshrc_

  ```sh
  source <(fnm env --use-on-cd)
  ```

- go

  `brew install go`

## Install Knut

Install knut globally. I have node and npm installed with fnm so they are under the users directory. This way I don't have issues with permissions.

```sh
npm i -g @jlrickert/knut-cli
```

## Setup kegs

Example kegs downloaded in a kegs directory

```sh
mkdir ~/kegs
git clone https://github.com/jlrickert/zet ~/kegs/jlrickert
git clone https://github.com/rwxrob/zet ~/kegs/rwxrob
```

## Setup Knut

Add the following in _~/.config/knut/config.yaml_

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/jlrickert/knutjs/main/packages/knut-core/kegSchema.json
format: yaml
kegs:
  - url: ~/kegs/jlrickert/docs
    alias: jlrickert
  - url: ~/kegs/rwxrob/docs
    alias: rwxrob
```

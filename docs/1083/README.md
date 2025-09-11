# Golang setup

[Golang](../1085) setup

Binaries may be installed on the [golang release page][release]

[release]: https://go.dev/dl/

## Ubuntu setup

```bash
VERSION=go1.25.1
sudo rm -rf /opt/go
curl -LO https://go.dev/dl/go${VERSION}.linux-amd64.tar.gz
sudo tar -C /opt -xzf ${VERSION}.linux-amd64.tar.gz go/
```

Add the following to your [dotfiles](../281)

```bash
export PATH="$PATH:/opt/go/bin"
```

## MacOS

I just use brew as go seems to be stable enough that the latest go version is the way to go.

## Windows

## FreeBSD

```bash
VERSION=go1.25.1
sudo rm -rf /usr/local/go
curl -LO https://go.dev/dl/${VERSION}.freebsd-amd64.tar.gz
sudo tar -C /usr/local -xzf ${VERSION}.freebsd-amd64.tar.gz go/
```

Add to ~/.bashrc

```bash
export GOROOT=/usr/local/go
export GOBIN="$HOME/.local/bin"
export GOPATH="$HOME/.local/share/go"
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

# For bash completions
. /usr/local/share/bash-completion/bash_completion
source $(ecw completion bash)
```
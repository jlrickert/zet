# Golang setup

Binaries may be installed on the [golang release page][release]

[release]: https://go.dev/dl/

## Ubuntu setup

```bash
sudo rm -rf /opt/go
curl -LO https://go.dev/dl/go1.24.5.linux-amd64.tar.gz
sudo tar -C /opt -xzf go1.24.5.linux-amd64.tar.gz go/
```

Add the following to your [dotfiles](../281)

```bash
export PATH="$PATH:/opt/go/bin"
```

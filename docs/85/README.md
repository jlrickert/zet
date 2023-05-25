# How to install rust properly

The rust installer likes to muck around with my dot files.

```bash
cd "$(mktemp -d)" || exit 1
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
if [[ "$(sha256sum rustup.sh)" = "be3535b3033ff5e0ecc4d589a35d3656f681332f860c5fd6684859970165ddcc" ]]; then
    sh rustup.sh --no-modify-path
fi
```

    #rust #coding #bash #cli #linux

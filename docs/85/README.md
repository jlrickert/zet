# How to install rust properly to prevent mucking with dotfiles

The rust installer likes to muck around with my dot files. It likes to
add an entry for its path. This is redundant to what I already have and
only adds noise as this is tracked by git. This is the script that I run
to install rather than using the default method on its website to get
around this issue. I also use a checksum to validate that the script
hasn't been tampered with for extra security.

```bash
cd "$(mktemp -d)" || exit 1
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
if [[ "$(sha256sum rustup.sh | cut -d' ' -f1)" = "be3535b3033ff5e0ecc4d589a35d3656f681332f860c5fd6684859970165ddcc" ]]; then
    sh rustup.sh --no-modify-path
fi
```

For reference the checksum was generated on Thu May 25 05:05:07 PM UTC 2023.

    tags: #rust #coding #bash #cli #linux

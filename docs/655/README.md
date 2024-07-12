# Handy pathing scripts

This is trick that I learned from [rob](../80) that I use in my [dotfile](../625).

Here is a snippet:

```bash
_pathappend() {
	for arg in "$@"; do
		test -d "$arg" || continue
		PATH=${PATH//":$arg:"/:} # remove all occuences of `:$arg:` from the PATH
		PATH=${PATH/#"$arg:"/}   # remove `"$arg:"` from the the beginning of the string
		PATH=${PATH/%":$arg"/}   # remove `":$arg` from the end of the string
		export PATH="${PATH:+"$PATH:"}$arg"
	done
}

# prepend to path if it exists
_pathprepend() {
	for arg in "$@"; do
		test -d "$arg" || continue
		PATH=${PATH//:"$arg:"/:}
		PATH=${PATH/#"$arg:"/}
		PATH=${PATH/%":$arg"/}
		export PATH="$arg${PATH:+":${PATH}"}"
	done
}
```

Example usage

```bash
_pathprepend \
	/usr/local/go/bin \
	/usr/local/bin \
	"${SCRIPTS}" \
	"${HOME}/.local/bin" \
	"${XDG_DATA_HOME}/flutter/bin" \
	"${CARGO_HOME}/bin" \
	"${FNM_HOME}" \
    "${HOME}/.config/emacs/bin" \
	"${PNPM_HOME}" \
	"${XDG_DATA_HOME}/go/bin" \
	"${DOTNET_ROOT}"

_pathappend \
	/usr/local/bin \
	/usr/local/sbin \
	/usr/local/games \
	/usr/games \
	/usr/sbin \
	/usr/bin \
	/snap/bin \
	/sbin \
	/bin
```

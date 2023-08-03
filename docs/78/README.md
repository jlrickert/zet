# Quick fix menus in vim

Quick fix is a windows for showing a list of all things of interest. It takes a input according to 'errorfmt'.

Example usage:

```
#This provides a list of python errors in modified files
vim -q <(git status -s | awk '$1 == "M" {print $2}' | xargs flake8)

# show grepped items
vim -q <(rg --line-number --no-heading --column YOUR_REGEX)
```

Once the quickfix menu is loaded it may be viewed by running `:copen`.

Example of available formats:

```text
{filename}:{linenumber}:{optional_message}
```

_`linenumber`_ needs to be 1 or more.

See also:

- [docs](https://vimdoc.sourceforge.net/htmldoc/quickfix.html#quickfix-window)
- [guide](https://freshman.tech/vim-quickfix-and-location-list/)
- [cool technique](https://til.codeinthehole.com/posts/how-to-use-stdin-to-populate-vims-quickfix-list/)
- [error formats](https://vim.fandom.com/wiki/Errorformats)

Meta:

    #vim #cli #linux #unix

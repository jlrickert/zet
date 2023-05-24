# Quick fix menus in vim

Quick fix is a windows for showing a list of all things of interest

vim [docs]

[docs]: https://vimdoc.sourceforge.net/htmldoc/quickfix.html#quickfix-window
[guide]: https://freshman.tech/vim-quickfix-and-location-list/

```
vim -q <(git status -s | awk '$1 == "M" {print $2}' | xargs flake8)
```

References:

- [^78.1]: https://freshman.tech/vim-quickfix-and-location-list/
- [^78.2]: https://til.codeinthehole.com/posts/how-to-use-stdin-to-populate-vims-quickfix-list/

See also

- [docs]: https://vimdoc.sourceforge.net/htmldoc/quickfix.html#quickfix-window
- [guide]: https://freshman.tech/vim-quickfix-and-location-list/
- [cool technique]: https://til.codeinthehole.com/posts/how-to-use-stdin-to-populate-vims-quickfix-list/

Meta:

    #vim #cli #linux #unix

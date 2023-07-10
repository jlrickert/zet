# My vim setup

Lately I have been using neovim rather than vim. The reason being is that I
spent some time setting up neovim and is more setup that my vim setup currently.
However, vim might be a better choice as it is more stable than neovim. I also
don't really use neovim as an IDE like I originally planned.

For managing dependencies is plug.vim. Here is how to quickly install it.

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

This is automated for me using [chezmoi]. See how I use [chezmoi] to manage my
[dotfiles](../221) for more information.

See my [vimrc] in my [dotfiles] repo

Here are my requirements:

- VSCode like tab completion
- Help docs
- LSP
- Formatting
- Linting
- Snippets

[vimrc]: https://github.com/search?q=repo%3Ajlrickert%2Fdotfiles%20.vimrc&type=code
[dotfiles]: https://github.com/jlrickert/dotfiles
[chezmoi]: https://www.chezmoi.io/

    tags: #cli #vim

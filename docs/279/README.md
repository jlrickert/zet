# Vim, tmux and ssh copy and paste madness

Copy and paste has always been a pita. I have found that using OSC52 works nice and seamlessly.

Here is a working example that I have found

- `vim-osc52`

  Add the following to vimrc

  ```bash
  autocmd TextYankPost *
    \ if v:event.operator is 'y' && v:event.regname is '+' |
    \ execute 'OSCYankRegister +' |
    \ endif
  ```

- Tmux needs `set -s set-clipboard on`
- Use `-Y` flag when using ssh. I have found that It doesn't work when using ssh from windows. Works when using WSL.
- Alacritty works out of the box
- Windows terminal also works

## Meta

    tags: #wsl #bash #ops

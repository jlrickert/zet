# Pop_OS! window management setup

The window management for [Pop_OS!](../7) is by far the best experience I have
had from a window manager. It brings the productivity features of tiling window
managers like i3. However, it still is not as fluid as `i3` and other tiling
window managers. At some point this may be improved as it is something that
one of the core developers believes fits as one if its core values[^6.1].

Here is an attempt to get to work like i3:

```bash
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10

gsettings set org.gnome.shell.keybindings switch-to-application-1  "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-2  "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-3  "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-4  "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-5  "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-6  "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-7  "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-8  "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-9  "[]"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1  "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2  "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3  "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4  "['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5  "['<Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6  "['<Super>6']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7  "['<Super>7']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8  "['<Super>8']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9  "['<Super>9']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Super>0']"

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1  "['<Super><Shift>1']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2  "['<Super><Shift>2']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3  "['<Super><Shift>3']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4  "['<Super><Shift>4']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5  "['<Super><Shift>5']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6  "['<Super><Shift>6']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7  "['<Super><Shift>7']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8  "['<Super><Shift>8']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9  "['<Super><Shift>9']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 "['<Super><Shift>0']"
```

[^6.1]: https://github.com/pop-os/shell/issues/823

Tags:

    #pop-os

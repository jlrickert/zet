# Arch linux setup on Terra

Terra is my old desktop that I use for development. The main reason that I develop on my desktop instead of on my newer faster labtop is that the labtop has a newer NVIDIA gpu that can run NVIDIA broadcast that I use for streaming.

## Bootrap the system

Follow the arch linux installation guide

- Partition type is GPT
- swap is 8G. I follow the [ubuntu recomendations] when not using hibernate. I rounded up to 64G as I only have 48G.
- Install `linux-zen` and `linux-zen-headers`

```bash
pacstrap -K /mnt base linux-zen linux-zen-headers linux-firmware vim intel-ucode
```

- For bootloader use systemd-boot.
- Edit `/boot/loader/entries/arch-zen.conf` to use the zen kernel. It should look like the following:

  ```bash
  title Arch Linux Zen
  linux /vmlinuz-linux-zen
  initrd /intel-ucode.img
  initrd /initramfs-linux-zen.img
  options root=PARTUUID=XXXX add_efi_memmap rw
  ```

  PARTUUID can be looked up using `lsblk`

  Make the following edit to `/boot/loader/loader.conf`

  ```bash
  default arch-zen.conf
  timeoute 3
  console-mode max
  editor no
  ```

  ```bash
  extra_kernel_version_strings linux-zen,linux-lts,linux
  ```

## Network setup

Install the dependencies:

```bash
pacman -Syu networkmanager nss-mdns
```

Edit the following in `/etc/nsswitch.conf`

```config
hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns
```

```bash
systemctl enable --now NetworkManager.service
systemctl enable --now systemd-resolved.service
```

## Setup man pages

```bash
pacman -Syu man-db man-pages
systemctl enable --now man-db.service
```

## Create a user

```bash
pacman -Syu sudo git zsh pipewire pipewire-docs wireplumber helvum pipewire-audio pipewire-alsa pipewire-pulse
useradd -m -G users,wheel -s /bin/zsh jlrickert
```

Enable wheel group to use sudo using `EDITOR=vim visudo`. wheel is used over sudo as other programs use it. Redhat and systemd prefer wheel and is preinstalled on arch. Ubuntu uses sudo group. `polkit` is something that uses wheel out of the box. Other than that It is mainly preference.

Also add `Defaults insults` just cause.

## Setup sound

For sound I find the newer pipewire seems to be mature enough for daily use.

```bash
pacman -Syu pipewire pipewire-docs wireplumber helvum pipewire-audio pipewire-alsa pipewire-pulse
systemctl --user enable --now pipewire-pulse.service
```

## Setup ssh

Install openssh

```
pacman -Syu openssh xorg-xauth
```

Make the following changes in `/etc/ssh/sshd_config`.

```bash
PermintRootLogin no
PubkeyAuthentication yes
AllowAgentForwarding yes
AllowTcpForwarding yes
X11Forwarding yes
PrintMotd yes
```

## Packages

```bash
pacman -Syu pkgfile
pkgfile -u
systemctl enable pkgfile-update.timer
systemctl start pkgfile-update.timer

pacman -Syu man-db man-pages
```

- [ ] TODO: `source /usr/share/doc/pkgfile/command-not-found.zsh` automation on arch linux

## Install graphics drivers

I have a Pascall (NV130) series GTX 1060 card [NV136 (GP106)]. Follow the [nvidia](https://wiki.archlinux.org/title/NVIDIA) guide on the arch wiki. I need to figure out if I should be using the noveou drivers as there are some things that are not compatible.

```bash
pacman -Syu --needed nvidia-dkms mesa
```

## Performance

```bash
pacman -Syu thermald btop i7z power-profiles-daemon
systemctl enable --now thermald
systemctl enable --now power-profiles-daemon.service
```

## System password manager

```bash
pacman -Sy gnome-keyring seahorse libsecret
systemctl --user enable --now gcr-ssh-agent.service
systemctl --user enable --now gnome-keyring-daemon.service
```

Update `/etc/pam.d/login` so it has the following content:

```bash
#%PAM-1.0

auth       required     pam_securetty.so
auth       requisite    pam_nologin.so
auth       include      system-local-login
auth       optional     pam_gnome_keyring.so
account    include      system-local-login
session    include      system-local-login
session    optional     pam_gnome_keyring.so auto_start
password   include      system-local-login
```

The lines where `pam_gnome_keyring.so` has been add is what needs to be added

Create the file `~/.config/systemd/user/ssh-agent.service` with the following contents:

```
[Unit]
Description=SSH key agent

[Service]
Type=simple
Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
# DISPLAY required for ssh-askpass to work
Environment=DISPLAY=:0
ExecStart=/usr/bin/ssh-agent -D -a $SSH_AUTH_SOCK

[Install]
WantedBy=default.target
```

Then activate the file with `systemctl --user enable --now ssh-agent.service`

VScode doesn't know how to use it. Add `"password-store": "gnome"` into `.vscode/argv.json`.

## Instaling aur packages

```bash
mkdir -p ~/repos/aur.archlinux.org
cd ~/repos/aur.archlinux.org
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay --sync --refresh --needed google-chrome visual-studio-code-bin zoom
```

## Dump

- [ ] TODO: `source /usr/share/doc/pkgfile/command-not-found.zsh` automation on arch linux
- `iwctl` for wifi.
- Sets keyboard speed `xset r rate 200 40`
- `setxkbmap -option caps:swapescape`

- Weather location for forest lake: 5027117

[ubuntu recomendations]: https://itsfoss.com/swap-size/

## See also

- [Labtop blaze](../287)

## Meta

    tags: #hardware #linux #workstation

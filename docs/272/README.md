# Arch linux setup on terra

Terra is my old desktop that I use for development.

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
  title ARch Linux Zen
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
pacman -Syu avahi nss-mdns
```

Edit the following in `/etc/nsswitch.conf`

```config
hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns
```

Create the following to `/etc/systemd/network/20-wired.network`.

```config
[Match]
Name=enp0s31f6

[Network]
DHCP=yes
```

You can lookup your lan device by running `ip link | grep enp | awk '{print $2}'`

Start all the services

```bash
systemctl start systemd-networkd
systemctl enable systemd-networkd
systemctl start systemd-resolved
systemctl enable systemd-resolved
systemctl start avahi-daemon.service
systemctl enable avahi-daemon.service
```

## Setup man pages

```bash
pacman -Syu man-db man-pages
```

## Create a user

```bash
pacman -Syu sudo git zsh pipewire pipewire-docs wireplumb helvum pipewire-audio pipewire-alsa pipewire-pulse
useradd -m -G users,wheel -s /bin/zsh jlrickert
```

Enable wheel group to use sudo using `EDITOR=vim visudo`. wheel is used over sudo as other programs use it. Redhat and systemd prefer wheel and is preinstalled on arch. Ubuntu uses sudo group. `polkit` is something that uses wheel out of the box. Other than that It is mainly preference.

Also add `Defaults insults` just cause.

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

## Performance

```bash
pacman -Syu thermald btop i7z
systemctl enable thermald
systemctl start thermald
```

## Security

- [ ] TODO: Figure out if meltdown is safe to disable

## Dump

- [ ] TODO: `source /usr/share/doc/pkgfile/command-not-found.zsh` automation on arch linux
- `iwctl` for wifi.

[ubuntu recomendations]: https://itsfoss.com/swap-size/

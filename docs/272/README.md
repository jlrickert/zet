# Arch linux setup on terra

Terra is my old desktop that I use for development.

1. Follow the installation guide

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

2. Configure network

   Add the following to `/etc/systemd/network/20-wired.network`. You can lookup your lan device by running `ip link | grep enp | awk '{print $2}'`

   ```bash
   [Match]
   Name=enp0s31f6

   [Network]
   DHCP=yes
   ```

   ```bash
   systemctl start systemd-networkd
   systemctl enable systemd-networkd
   systemctl start systemd-resolved
   systemctl enable systemd-resolved
   ```

3. Setup man pages

   ```bash
   pacman -Syu man-db man-pages
   ```

4. Create a user

   ```bash
   pacman -Syu sudo zsh
   ```

`iwctl` for wifi.

[ubuntu recomendations]: https://itsfoss.com/swap-size/

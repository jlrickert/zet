# Arch linux setup on terra

Terra is my old desktop that I use for development.

1. Follow the installation guide

   - Partition type is GPT
   - swap is 8G. I follow the [ubuntu recomendations] when not using hibernate. I rounded up to 64G as I only have 48G.
   - Install `linux-zen` and `linux-zen-headers`

   ```bash
   pacstrap -K /mnt base linux-zen linux-zen-headers linux-firmware vim
   ```

   - Edit `/boot/loader/entries/arch.conf` to use the zen kernel
   - For bootloader use systemd-boot.

     Make the following edit to `/boot/EFI/refind/refind.conf`

   ```bash
   extra_kernel_version_strings linux-zen,linux-lts,linux
   ```

   Install the microcode

   ```bash

   ```

3. Configure network

   ```bash

   ```

   ```bash
   systemctl start systemd-networkd
   systemctl enable systemd-networkd
   systemctl start systemd-resolved
   systemctl enable systemd-resolved
   ```

4. Setup man pages

   ```bash
   pacman -Syu man-db  man-pages
   ```

5. Create a user

   ```bash
   ```

`iwctl` for wifi.

[ubuntu recomendations]: https://itsfoss.com/swap-size/

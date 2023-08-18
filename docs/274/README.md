# Setting up refind as a boot loader

Here is an attempt at setting up refind as the bootloader. I gave up half way through and went the `systemd-boot` route.

```bash
pacstrap -K /mnt base linux-zen linux-zen-headers linux-firmware vim
```

- Edit `/boot/loader/entries/arch.conf` to use the zen kernel
- For bootloader use systemd-boot.

  Make the following edit to `/boot/EFI/refind/refind.conf`

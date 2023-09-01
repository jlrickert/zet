# Arch linux setup on blaze

Blaze is my dell xps 9710. It is setup similar to [Terra](../272). This is what I use to develop on when I want to be mobile.

## Harddrive setup

- hard drive is on `/dev/nvme1n1`

| Partition | Type Code | Size     |
| --------- | --------- | -------- |
| /boot     | 1 (EFI)   | 1G       |
| swap      | 19        | 64G      |
| /         | 23        | The rest |

## Hibernate and suspend

Currenlty s2idle is supported. No S3 support

- Add `resume` to HOOK in `/etc/mkinitcpio.conf`
- Add `resume=PARTUUID=XXXX` to boot entries

## HiDPI setup

Copy the following into `~/.Xresource`.

```bash
Xft.antialias: true
Xft.hinting:   true
Xft.rgba:      rgb
Xft.hintstyle: hintfull
Xft.dpi:       220
```

## Keyboard

Since I general don't have my nice [keyboard](../290) connected when using my labtop I need to swap caps lock and escape.

## Notes

- `edk2-shell` might insight into how to add windows to the list of boot entries.

## See also

- https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Configure_the_initramfs

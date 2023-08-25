# Arch linux setup on blaze

Blaze is my dell xps 9710. It is setup similar to [Terra](../272).

## Notes

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

## Notes

- edk2-shell

## See also

- https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Configure_the_initramfs

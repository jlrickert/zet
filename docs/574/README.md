# Running FreeBSD VM on apple silicon with QEMU

I managed to get the virtual box image to run using UTM on MacOSX 14.4.1.

UTM is a frontend for [QEMU](../574) that I find works.

Download a QEMU virtual machine image with the qcow format. I use the zfs variant for now. See [file system recommendation](../575)

Once installed it may be uncompressed with `unxz`. For example `unxz FreeBSD-14.1-RELEASE-arm64-aarch64-zfs.qcow2.xz`. Should also be able to emulate an x86 architecture as well.

Settings

- network1: bridge mode
- drive1: VirtIO and select the qcow2 image and select the size

  This will create a copy of it and will not modify the image. This diffs from the behavior of VirtualBox. Set the image size to the size you want.

I have not figured out a way to resize images yet if you run out of hard drive space.

## Basic setup

```bash
pkg update
pkg upgrade
pkg install zsh
useradd ## Interactively adds a user
```

## See also

- [Converting VDI to QCOW](../577)
- [VirtualBox](../576)
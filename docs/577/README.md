# Converting a VirtualBox VDI to a QEMU on MacOSX

With just installing UTM I wasn't able to select the `vdi` image. However, between installing the test version of [VirtualBox] and running a command to convert it to a RAW format. UTM was surprisingly able to open the `vdi` image.

A test build of [VirtualBox](../576) may be installed. From there you can use the cli tool to convert. For example:

```bash
VBoxManage clonemedium disk FreeBSD13.2_UFS.vdi ecwdev.img --format=raw
```

I got the idea from a [blog] post but seems to be outdated as the VBoxManage commands seem to have changed

[blog]: https://sysadmin102.com/2024/01/utm-converting-vdivirtualbox-raw-vmdkvmware-image-to-qemu-image-qcow2/

- [ ] TODO: this doesn't seem right. I want `qcow` not `img`

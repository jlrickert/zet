# Migrating Virtualbox VM to Proxmox

Create a VM over to Proxmox. This works on version 8.2.2

- Convert `.vmi` to `.raw` or `.qcow2` (recommended)
- Move image to the Proxmox server
- Create VM in Proxmox.

  Remove any disks. Adjust settings as needed. Keep a note of the **VM ID**.

- Import disk image to the created VM

  Import the disk. Should look like the following
  `qm importdisk 106 ./image.qcow2 pxe-image`. Here `./image.qcow2` is the path
  to the image to import and `pxe-image` is the created storage. In this case
  `pxe-image` is a storage powered by [NFS](../877).

- Ensure that the storage is the first for boot order.
- Start up the VM

## Troubleshooting

One of the most common issues is changes in drivers. Disks and network devices
are an example. Chances are you need to reconfigure them.

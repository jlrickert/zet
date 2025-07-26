# Ubuntu template cloud version 1 for my homelab

My second template for my [homelab](../578) is my fist attempt at making a cloud based VM. It is a simple template of Ubuntu 24.04. Template name is `ubunut-2404-cloud-v1`. This is an experment initiating a VM using cloud init. Patch applied on 2025-07-26.

## Configuration dump

```
root@pve:~# qm config 105
agent: 1
boot: order=scsi0;ide2;net0
cipassword: **********
ciuser: jlrickert
cores: 2
cpu: x86-64-v2-AES
ide0: local-lvm:vm-105-cloudinit,media=cdrom
ide2: pxe-data:iso/noble-server-cloudimg-amd64.img,media=cdrom,size=600338K
ipconfig0: ip=dhcp,ip6=dhcp
memory: 4096
meta: creation-qemu=9.2.0,ctime=1753555327
name: ubuntu-2404-cloud-v1
net0: virtio=BC:24:11:3B:FC:BD,bridge=vmbr0,firewall=1
numa: 0
ostype: l26
scsi0: local-lvm:base-105-disk-1,size=36352M
scsihw: virtio-scsi-single
serial0: socket
smbios1: uuid=5b5570dc-3d12-43aa-88c1-9a1e6940c0ef
sockets: 1
sshkeys: ssh-ed25519%20AAAAC3NzaC1lZDI1NTE5AAAAIKZQPSbEwoDXP42HyE5v4uJ5EC6OpYecPeslMdxQ3KUw%20admin%40jlrickert.me%0A
template: 1
vmgenid: 7b247ce6-f484-487d-b743-94efd6a21e86
```

## Steps to recreate

Steps are taken from <https://pve.proxmox.com/wiki/Cloud-Init_Support#_preparing_cloud_init_templates>

- Upload the latest image from <https://cloud-images.ubuntu.com/>. I put it on the pxe-data storage.
- Create the VM from the config dump. Skip adding a hardrive for now
- Create the hard drive on the cli

  ```bash
  qm set <vmid> --scsi0 local-lvm:0,import-from=/mnt/pve/pxe-data/template/iso/noble-server-cloudimg-amd64.img
  ```

- Increate the hard drive by 32G increment
- Hit clone and your off
- Login via `ssh <vmname>.int.jlrickert.me`. May have to wait a while

## Resources

- https://pve.proxmox.com/wiki/Cloud-Init_FAQ
- https://pve.proxmox.com/wiki/Cloud-Init_Support
- https://blog.themaxtor.boo/post/2024-10-12-how-to-create-proxmox-template-with-cloud-image/
- https://blog.themaxtor.boo/post/2024-10-19-how-to-create-vm-with-cloud-init-in-proxmox/

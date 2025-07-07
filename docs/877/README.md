# Using TrueNAS NFS for Proxmox images

This is an experiment to see how well moving the VM disk over to my [TrueNAS](../676) server currently running on [ts140](../563).

What I found is it works very well. There is also iSCSI to look into as well.

## NFS on TrueNAS setup

Steps:

- Create a user (I named it pxe)

  Users shell is `/usr/sbin/nologin`

- Create a datastore under Datasets

  - main/pxe/pxe-backup
  - main/pxe/pxe-data
  - main/pxe/pxe-images

- Update permissions

  Currently I have lax permissions where the user and group is pxe. rwx is 777.

## Proxmox setup

Configuration is found at **Datacenter -> Storage**

Add a NFS device. Recommended to use the IP address.

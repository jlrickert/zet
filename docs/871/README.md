# Connecting to Truenas storage volumes with NFS on my MacOS

I found a way to connect to nfs volumes on my [mac](../583) that are hosted on my [TrueNAS](../676) server [ts140](./563) that I use on my [homelab](./578).

```bash
sudo mkdir /Volumes/pxe
sudo mount -t nfs -o resvport,rw 192.168.50.4:/mnt/main/pxe /Volumes/pxe
```

This was largely learned from an [article](../874) I found online.
# Ubuntu template version 1 for my homelab

My first template for my [homelab](../578) is version 1. It is a simple template of Ubuntu 24.04. Template name is `ubunut-2404-base-v1`.

## Steps to recreate

- Simply Create an Ubuntu VM. Username is `jlrickert` with my usual password. Setup default shell as zsh.

## Base configuration

- General
  - **name:** ubuntu-2404-lts-v1
- OS
  - **iso:** ubuntu-24.04.2-live-server-amd64.iso
- System
  - **BIOS:** OVMF
  - **EFI Storage:** local-lvm
  - **QEMU Agent:** [x]
  - **SCSI Controller:** VirtIO SCSI single
- Disk
  - **Bus/Device:** SCSI
  - **Disk Size:** 32G
  - **Cache:** No Cache
  - **Discard:** [x] Running on local NVME drive
- CPU
  - 2 cores
- MEMORY
  - 2048 MiB

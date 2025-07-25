# Ubuntu template version 2 for my homelab

My second template for my [homelab](../578) is version 1. It is a simple template of Ubuntu 24.04. Template name is `ubunut-2404-base-v2`. This is a migration over to cloud-init to experiment with.

## Steps to recreate

- Make a clone of [Ubuntu v1](../1062)
- Generate ssh keys to allow VM's to pull code. GitHub should be configured to accept it

  ```bash
  ssh-keygen -t ed25519 -C "Github deploy key the homelab" -f ./id_ed25519_homelab
  ```
# [x] Homelab Task | setup DNS

Setup 2 [pi holes](../662) for my [homelab](../578).

9.9.9.9 and 149.112.112.112

## Installation process steps

- Install 2 [Ubuntu] version 24.04 on [proxmox](../635) that is running on [trooper](../581).
- Roughly 2G and 2 CPU is what I have setup. Also ensure they boot up on startup
- For networking I use the following setup

  ```
  192.168.50.20 pihole-1.int.jlrickert.me
  192.168.50.21 pihole-2.int.jlrickert.me
  ```

  Use quad9 for dns

- Install: `curl -sSL https://install.pi-hole.net | bash`
- Set password: `pihole -a -p`

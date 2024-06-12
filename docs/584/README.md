# [ ] Homelab 2024 task | build up my homelab

## Time log

- 2024-06-07 (4h) Setup ansible

  Setup basic things such as creating user and packages

- 2024-06-08 (4h) Fucking around with [FreeBSD virtual machines](../584)

  Ended up learning what not to for managing FreeBSD VM's. Need to find a way to resize images

- 2024-06-08 (4h) Setup DNS on ansible

  Setup coredns on the homelab

- 2024-06-09 19:24 (1h 30m) Name resolution

  Setup mDNS and NetBIOS name resolution with Avahi and Samba

- 2024-06-09 20:46 (1h) Playing with logging

  Discovered that CoreDNS rc file uses daemon that redirects stdout and stderr to /var/log/daemon.log.

- 2024-06-12 00:22 (2h 30m) [Setting up wireguard site to site](../590)

  Managed to get charm and ts140 to communicate over VPN in a point to point configuration. Still haven't figured out how to get either to forward packets yet to hosts on each others networks.

## See also

- [Current home lab](../578)

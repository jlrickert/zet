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

  Managed to get charm and [ts140] to communicate over VPN in a point to point configuration. Still haven't figured out how to get either to forward packets yet to hosts on each others networks.

- 2024-06-29 03:00 (5h) Setting up [ts140] with [pfSense](../611)

  Installed pfSense on the [ts140]. I have the LAN connected to the new network card and the old one connected to the WAN. For some reason I am only getting 800 Mbits out if rather than the 950 MBits that I was getting previously

- 2024-07-01 01:18 (5.15h) Spent time setting up Wireguard on [ts140]

[ts140]: ../563

## See also

- [Current home lab](../578)
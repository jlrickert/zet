# Networking in Ubuntu 24.04

Configuration is found in `/etc/netplan/01-netcfg.yaml`. Netplan was introduced in Ubuntu 20.04 (Focal Fossa).

- Promiscuity mode on a device `ip -d link show enps018`

  May be needed for macvlan or ipvlan for a bridge setup with docker.

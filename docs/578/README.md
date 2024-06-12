# My current homelab setup

## VLANS

Need to buy hardware for this.

## Network layout

My whole network in my home lab will be on 10.10.0.0/16

### Core infrastructure on on 10.10.10.0/24

This will be on VLAN10

- ts140.int.jlrickert.me: 10.10.10.1
- luna.int.jlrickert.me: 10.10.10.3
- trooper.int.jlrickert.me: 10.10.10.2

### Virtual machines on 10.10.20.0/24

This will be on VLAN20

- php71.int.jlrickert.me: 10.10.20.xx
- php74.int.jlrickert.me: 10.10.20.xx
- php81.int.jlrickert.me: 10.10.20.xx

### Internet of things on 10.10.0.0/24

For now my r7000 will act as both an access point and router until I get what I need for ts140.

- r7000: 10.10.0.1
- jlrickert-mbp.int.jlrickert.me: 10.10.0.xx
- jlrickert-xps.int.jlrickert.me: 10.10.0.xx

### Wireguard things

Network will be 10.0.0/16

### Work things

Work network will be on a separate network at 10.1.0.0/16

## Machines

- mbp.int.jlrickert.me
- ts140.int.jlrickert.me

  This will be running FreeBSD 14. Services include: CoreDNS, DHCP, PostgreSQL, Email, backup services, etc.

- trooper.int.jlrickert.me

  This will be the primary app server. It will be running either proxmox or a lighter alternative.

## Hardware

- [Think Server 140](../563)

  This will be running FreeBSD. This sill be my router, DNS, DHCP, and firewall.

- [Netgear R7000](../579)
- [Custom PC](../581)

Other devices

- [MBP](../583)
- [XPS](../564)

## Example home labs

- [rwxrobs homelab](https://app.excalidraw.com/l/6rjSvoGlOkc/1njNB1sKmj8)

## See also

- [Task to build the homelab](../584)
- [Homelab git repo](https://github.com/jlrickert/homelab)

  Ansible scripts that I use to manage my infrastructure

- [Marionette](https://github.com/jlrickert/marionette)

  My old setup.  I no longer use but keep around as a reference


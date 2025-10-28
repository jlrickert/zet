# Patch | Homelab - Setting up DNS with Unbound with DHCP DNS registration

I figured out how to make it so that when devices connect to the LAN on my
[homelab](../578) there `hostname` becomes registered in the DNS. This only
applies to devices added via DHCP from ISC DHCPv4.

One issue with this is that when 2 hosts come up with the same **hostname**.
Duplicates will get additional entries in the DNS.

The key is found under **Services -> Unbound DNS -> General**. Check the box
**Register ISC DHCP4 Leases**.

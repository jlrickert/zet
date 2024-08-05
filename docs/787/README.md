# [ ] Homelab Task: Road Warrior WireGuard VPN setup on OPNSense

This is what I found works for a VPN setup after initially [installing](../772) OPNsense on my [EQ12](../699). OPSense is a [Road Warrior] guide on how to setup it up. I was able to follow it to a T as this is a rather new setup and have not done anything complex yet. I used the same Interface name of `HomeWireGuard`.

I have the clients setup route all traffic (`0.0.0.0/0, ::0`) or just to the LAN (`192.168.50.0/24, 192.168.150.0/24`). DNS is set to `192.168.50.20`, and `192.168.50.21`.

One thing to note is that MTU 1360 needs to be set on a Mac if using wire guard cli. Not sure why yet. MTU 1280 the smallest recommended MTU and should be the most compatible.

WireGuard (group) enabling LAN access breaks things. Why?

[Road Warrior]: https://docs.opnsense.org/manual/how-tos/wireguard-client.html

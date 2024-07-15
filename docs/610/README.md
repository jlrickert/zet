# [x] Homelab Task | setup a vpn

Working example on 2024-07-02. Just need to figure out why I cannot access everything on the LAN.

Need to setup a reliable VPN so I can access my home network. Currently, I plan on making the VPN work on [ts140](../563)

`qrencode -t ansiutf8 < tunnel.conf`

## Specs

- Port 51820 on [ts140](../563)

  This is the default gateway at home running [pfSense](../611)

- Clients will be able to connect to home network via <jlrickert.me>. This will point to the WAN of my home address. Need to find a mechanism to do this.

## Topology

| Device          | IP Address       |
| --------------- | ---------------- |
| [ts140](../563) | 192.168.150.1/24 |
| [mbp](../583)   | 192.166.150.2/32 |
| [s22](../612)   | 192.168.150.3/32 |
| [xps](../564)   | 192.168.150.4/32 |

## Firewall rules

> [!NOTE] WG0 is WireGuard

| Interface | Proto | Source | Port | Dest     | Port  | Description            |
| --------- | ----- | ------ | ---- | -------- | ----- | ---------------------- |
| WG0       | ANY   | \*     | \*   | \*       | \*    | Allow all on WG        |
| WAN       | UDP   | \*     | \*   | WAN addr | 51280 | Allow WG               |
| OPT1      | ANY   | \*     | \*   | \*       |       | Allow WG on everything |

Outbound NAT to allow wireguard out of the WAN

- Hybrid outbound NAT
- interface: WAN
- Source: OPT1 network
- Source Port: \*
- Destination: \*
- Destination Port: \*
- NAT Address: WAN address
- NAT Port: \*

## See also

- [Homelab project](../578)
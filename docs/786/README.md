# Issue: Proxmox inaccessible

Was unable to directly connect to Proxmox from both ssh or UI. Ping also didn't work. However, what I could do is connect on of the hosted VM's on it as a proxy. Those had access.

It was an issue where WireGuard was misconfigured. IP address were using LAN IP address ranges instead of its own subnet. E.g. 192.168.50.1/32 instead of 192.168.150.1/32 and so on.

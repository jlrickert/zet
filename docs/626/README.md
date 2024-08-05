# Current Homelab topology

## DNS

I have 2 [Pi Holes](../662) setup that handle the internal DNS. I have them setup to forward to [quad9](../668). Currently they are running on [proxmox](../635)

See DNS [task](../667) to see how to setup.

## Network layout

### Main network 192.168.50.0/24

Core devices. These are physical devices. Hopefully I will never have more than 18.

```
192.168.50.1/24 A eq12.int.jlrickert.me
192.168.50.2/24 A trooper.int.jlrickert.me
192.168.50.3/24 A be550.int.jlrickert.me
192.168.50.4/24 A ts140.int.jlrickert.me
```

DHCP will be between 192.168.50.50/24 to 192.168.50.200/24

VM's running in proxmox

```
192.168.50.20/24 A pihole-1.int.jlrickert.me
192.168.50.21/24 A pihole-2.int.jlrickert.me
192.168.50.22/24 A app-1.int.jlrickert.me
```

Applications

```
rtr1.int.jlrickert.me      CNAME eq12.int.jlrickert.me
ap1.int.jlrickert.me       CNAME be550.int.jlrickert.me
ns1.int.jlrickert.me       CNAME pihole-1.int.jlrickert.me
ns2.int.jlrickert.me       CNAME pihole-2.int.jlrickert.me
nextcloud.int.jlrickert.me CNAME app-1.int.jlrickert.me
proxmox.int.jlrickert.me   CNAME trooper.int.jlrickert.me
```

### Other Virtual machines on 192.168.60/24

Is this a good idea that it is on a different network?

```
192.168.50.71 A php71.int.jlrickert.me
192.168.50.74 A php74.int.jlrickert.me
192.168.50.81 A php81.int.jlrickert.me
```

### Wireguard things

Network will be 192.168.150.0/24

### Work things

Work mock network will be on a separate network at 10.1.0.0/16

## Web interfaces

- DNS web GUI: <192.168.50.20/admin>
- DNS web GUI: <192.168.50.21/admin>
- opnsense: <192.168.50.1>
- Access point: 192.168.50.3

## Other considerations

### VLANS

Don't plan on using as I don't want to spend time working on it.

## See also

- [Homelab](../578)
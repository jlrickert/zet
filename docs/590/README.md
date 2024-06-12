# [ ] Homelab 2024 task | setup site to site configuration

Site to site configuration between digital ocean droplet (charm) and server at home (ts140). This is my first iteration. The goal is to get some simple communication between the 2.

## ts140.int.jlrickert.me

This is my server that is behind a NAT

- em0 ip: 10.10.10.1/16
- wg0 ip: 10.0.0.1/31
- config

  ```conf
  ```

## charm.jlrickert.me:

- eth0 24.199.80.67/20
- eth1 10.116.0.3/20
- default via 24.199.80.1 eth0
- wg0 10.0.0.1/31

  ```conf
  # charm
  [Interface]
  PrivateKey = CHARM_PRIVATE_KEY
  Address = 10.0.0.1/31
  ListenPort = 51800

  # ts140
  [Peer]
  PublicKey = TS140_PUBLIC_KEY
  AllowedIPs = 10.0.0.2/32, 10.10.0.1/24
  ```

## Facts

- Set `PersistentKeepalive = 25` when behind a NAT and would like to receive connections
- `AllowedIPs` must be host IP addresses

## See also

- [Main task](../584)

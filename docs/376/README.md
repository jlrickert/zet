# Wireguard for AWS VPC access gateway for Ubuntu server

Create an EC2 instance on a public VPC.

## Install wireguard software

```bash
sudo apt install wireguard wireguard-tools
```

## Enable forwarding on the sever

Make sure the following settings are enabled in `/etc/syslog.conf`:

```conf
net.ipv6.conf.all.forwarding=1
net.ipv4.ip_forward=1
```

Run `sudo sysctl -p` after changing

## Generate keys

Copy pasta below to create key pairs.

```bash
wg genkey | (umask 0077 && tee server.key) | wg pubkey > server.pub
wg genkey | (umask 0077 && tee macos.key) | wg pubkey > macos.pub
wg genkey | (umask 0077 && tee phone.key) | wg pubkey > phone.pub
```

## Server config for think-server

Add the following contents to `/etc/wireguard/wg0.conf`

This use to work

```text
[Interface]
PostUp = ufw route allow in on wg0 out on eth0
PostUp = iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE
PostUp = ip6tables -t nat -I POSTROUTING -o eth0 -j MASQUERADE
PreDown = ufw route delete allow in on wg0 out on eth0
PreDown = iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
PreDown = ip6tables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

PrivateKey = SERVER_PRIVATE_KEY
ListenPort = 51800
Address = 10.0.0.1/24
SaveConfig = true

# remote device
[Peer]
PublicKey = DEVICE_PUBLIC_KEY
AllowedIPs = 10.0.0.2/24
```

This also works

```
[Interface]
PrivateKey = CONTENTS_OF_SERVER_KEY
ListenPort = 51800
Address = 10.0.0.1/24
SaveConfig = true

# if the server is behind a router and receives traffic via NAT, these iptables rules are not needed
PostUp = iptables -A FORWARD -i %i -j ACCEPT                                                                                          PostUp = iptables -A FORWARD -o %i -j ACCEPT
PostUp = iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT                                                                                        PostDown = iptables -D FORWARD -o %i -j ACCEPT
PostDown = iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE


# remote device for macos
[Peer]
PublicKey = CONTENTS_OF_MACOS_PUB
AllowedIPs = 10.0.0.2/24

# remote device for phone
[Peer]
PublicKey = CONTENTS_OF_PHONE_PUB
AllowedIPs = 10.0.0.3/24
```

This may then be started by running the following:

```bash
systemctl enable wg-quick@wg0.service
systemctl start wg-quick@wg0.service
```

## Remote device config

```text
[Interface]
DNS = 8.8.8.8
Address = 10.0.0.3
ListenPort = 51800
PrivateKey = DEVICE_PRIVATE_KEY

[Peer]
PublicKey = SERVER_PUBLIC_KEY
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = 24.220.78.24:51800
```

This may then be started by running the following:

```bash
systemctl enable wg-quick@wg0.service
systemctl start wg-quick@wg0.service
```

## Setting up on macos

```bash
brew install wireguard-go wireguard-tools
sudo mkdir /usr/local/etc/wireguard
```

Create the following things in `/usr/local/etc/wireguard`

- macos.pub
- macos.key
- server.pub
- wg0.conf

The contents of `wg0.conf` should look like the remote device config.

start the service by running the following:

```bash
sudo wg-quick up wg0
```

To bring down run

```bash
sudo wg-quick down wg0
```
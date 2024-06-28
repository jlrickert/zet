# FreeBSD networking overview

- `/etc/rc.conf`
- `/etc/rc.conf.local`

```
sysrc ifconfig_em0="inet 10.10.10.1 netmask 255.255.0.0"
sysrc defaultrouter="10.10.0.1"
sudo service netif restart
```

## DHCP

```bash
sudo dhcpclient em0
```

## DNS

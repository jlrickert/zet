# Common network ranges used in private networks

## Private subnets:

- 10.0.0.0 to 10.255.255.255 (10.0.0.0/8)
- 172.16.0.0 to 172.31.255.255 (172.16.0.0/12)
- 192.168.0.0 to 192.168.255.255 (192.168.0.0/16)

### Subnets used by platforms and applications

These are the defaults

- Hyper-V: 192.168.137.0/24
- Azure: 10.x.x.x/16 or 10.x.x.x/24
- AWS: 10.x.x.x/16, 172.31.x.x/16, or 192.168.x.x/16
- VirtualBox nat: 10.0.2.0/24
- VirtualBox Host only: 192.168.56.0/24
- Docker: 172.17.0.0/16
- Flannel: 10.244.0.0/16
- Calico: 192.168.0.0/16
- Weave: 10.32.0.0/12
- Canal: Either Calico or Weave subnets depending on configuration

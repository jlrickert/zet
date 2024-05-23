# Local network machine IP address discovery protocols

Zeroconf / Bonjour

This will broadcast its dns name using mDNS. For example, if a PC is named jlrickert-xps it will register its dns on the local system as jlrickert-xpx.local

```
nmap -sn 192.168.1.0/24
arp -an
```

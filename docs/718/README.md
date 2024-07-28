# Networking on MacOSX

Figure out where DNS gets resolved:

```bash
scutil --dns
```

## Troubleshooting

Flush DNS:

```bash
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
```

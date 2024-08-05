# [ ] Homelab Task: Updating CloudFlare based email forwarding

Follow the [gist]. Only issue is that DKIM doesn't work (marked as spam possibly).

```
TXT jlrickert.me	v=spf1 include:_spf.google.com include:_spf.mx.cloudflare.net ~all
```

[gist]: https://gist.github.com/irazasyed/a5ca450f1b1b8a01e092b74866e9b2f1
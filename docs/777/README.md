# Setting up Digital Ocean DDNS on OPNSense

Digital ocean provides an [API] endpoint to update DNS entries. OPNsense is able to periodical able to call this endpoint using the ddclient plugin.

```bash
opnsense-patch -c plugins 9d8564c
```

Add the following custom configuration:

```bash
curl -X POST \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
-d '{"type":"A","name":"www","data":"__MYIP__","priority":null,"port":null,"ttl":1800,"weight":null,"flags":null,"tag":null}' \
"https://api.digitalocean.com/v2/domains/__HOSTNAME__/records"
```

Of course don't forget to change the token. See [script](keg:priv/1170) for full example.

[API]: https://docs.digitalocean.com/products/networking/dns/how-to/manage-records/
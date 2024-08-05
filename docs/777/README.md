# Setting up Digital Ocean DDNS on OPNSense

OPNsense is able to periodical able to call this endpoint using the `ddclient` plugin. This needs to be manually installed. The plugin needs to be selected as the backend under general settings. Interval should be at least 600 as well. From there the user name should be the same as the value found on the avatar icon (top right) drop-down. Password is an API token created in the DigitalOcean interface. Mine will expire in like 1 month.

General settings:

- interval: 600 or more (some services will ban you if you do too often)
- backend: `ddclient` (requires installing plugin)

Accounts settings

- Service: Digitalocean
- Username: `jaredrickert52` (value found from avatar dropdown top right)
- password: (API token)
- zone: `jlrickert.me`
- hostnames: `[vpn.jlrickert.me]`
- check IP method: interface
- interface to monitor: WAN

## Attempts

### Custom patch

Found something online that patched it in.

```bash
opnsense-patch -c plugins 9d8564c
```

Turns out just need to set this as the backend to use

### Api and cron

Digital ocean provides an [API] endpoint to update DNS entries. Had ddclient installed and was just going to setup a simple cron job. This is FreeBSD as a base after all.

Add the following custom configuration:

```bash
curl -X POST \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
-d '{"type":"A","name":"www","data":"__MYIP__","priority":null,"port":null,"ttl":1800,"weight":null,"flags":null,"tag":null}' \
"https://api.digitalocean.com/v2/domains/__HOSTNAME__/records"
```

http://checkip.dyndns.org/

Of course don't forget to change the token. See [script](keg:priv/1170) for full example.

[API]: https://docs.digitalocean.com/products/networking/dns/how-to/manage-records/
# Overview: backing up Unix systems

## Simple approach

On system to be backed up

```
sudo tar czf "$(hostname -s)-$(date -I).tgz" /etc /usr/local/etc /home
cd /tmp
```

Then copy over the file that was created

> [!WARNING] The following command is destructive

To restore move back over to the system and run `tar -tzvf /tmp/backup.tgz`.

To unpack for view run something like `mkdir -p /tmp/temproot && tar -tzvf /tmp/backup.tgz -C /tmp/temproot`. If you want a specific directories append the path(s) to the command.

Examples taken from ubuntu [docs]

[docs]: https://ubuntu.com/server/docs/how-to-back-up-using-shell-scripts
# Hilarious way to copy and paste into a VM

Learned from `tehbread` on [rwxrob's stream](../628). Basically, generate an error value in the log and get it from there.

> [!NOTE]
>
> Don't do this with secrets

```bash
# On host
ssh -l "$(awk "{print $2}" ~/.ssh/id_ed25519.pub)"

# On machine
journalctl -u sshd | grep "Invalid user"
```

## The hacker ways to do it

`nc` is another great way.

On server

```
nc -l 4545 | tee -a /tmp/buffer
```

On client

```
echo "message" | nc example.com -p 4545
```
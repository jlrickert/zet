# Testing raw performance of hard drives with dd

Testing write speed

```bash
time dd if=/dev/zero of=/path/to/file bs=1m count=30720
```

Testing read speed

```bash
time dd if=/path/to/file of=/dev/null bs=1m
```

> [!NOTE]
>
> `/path/to/file` is a file on the device

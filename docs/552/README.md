# Managing disks on MacOS

Use `diskinfo`

File of interest

- `/etc/fstab`
- `/etc/synthetic.conf`

## Tracking down processes that have a file open

An example where I had a few processes held a network drive open so I could not close it

```bash
fuser /Volumes/jlrickert/
ps -fp 42056 43368 43375 4337
```

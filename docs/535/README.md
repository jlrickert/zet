# How to mount a sambda drive on macosx CLI

To mount use something like this. This is incomplete.

```bash
mount -t smbfs //devel@10.1.0.84/share /Volumes/share
```

Open up the share in finder. This will open up the share in Finder.app. This

```bash
open 'smb://username@hostname/share'
```

# Github CLI tips and tricks

Set the origin to use the ssh url.

```bash
git remote set-url origin "$(gh repo view --json sshUrl | jq '.sshUrl')"
```

    tags: #bash #github #cli

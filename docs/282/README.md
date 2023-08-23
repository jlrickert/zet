# Github CLI tips and tricks

Set the origin to use the ssh url.

```bash
git remote set-url origin "$(gh repo view --json sshUrl | jq '.sshUrl')"
```

Clone all of your repositories and switch to sshUrl

```bash
for x in $(gh repo list | awk '{print $1}'); do
  gh repo clone $x
  cd $x
  git remote set-url origin "$(gh repo view --json sshUrl | jq '.sshUrl')"
  cd -
done
```

    tags: #bash #github #cli

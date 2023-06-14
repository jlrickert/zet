# How to manage ssh keys

SSH keys are the preferred way to handle ssh connects rather the use of
passwords.

Here is a quick way to create and set the files directories with the
correct permissions.

```bash
mkdir ~/.ssh
chmod  0700 ~/.ssh
chmod  0600 ~/.ssh/id_ed25519
chmod  0644 ~/.ssh/id_ed25519.pub
```

Key types:

- ed25519
- rsa

```bash
# create a ed25519 ssh key with a password and comment.  An empty
# password for no password
ssh-keygen -t ed25519 -f "$HOME/id_ed25519_name" -C "your comment"
```

Constant password prompts are annoying.  Here is how to get rid of them
on MacOSX

```bash
ssh-add --apple-use-keychain
```


Meta:

    #cli #devops

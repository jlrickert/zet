# How to manage ssh keys

SSH keys are the preferred way to handle ssh connects rather the use of passwords.

Here is a quick way to create and set the files directories with the correct permissions.

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

Constant password prompts are annoying. Here is how to get rid of them on MacOSX.

```bash
ssh-add --apple-use-keychain
ssh-add --apple-use-keychain ~/.ssh/id_ed25519_your_key
# shortcut if sshkey is setup
for i in $(sshkey list); do ssh-add --apple-use-keychain "$HOME/.ssh/$i"; done
```

To enable enable logging into a system using your ssh key use `ssh-copy-id`. Here is an example

```bash
ssh-copy-id -i ~/.ss~/.ssh/id_ed25519_your_key terra.local
```

Meta:

    #cli #devops

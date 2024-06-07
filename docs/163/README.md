# How to manage ssh keys

SSH keys are the preferred way to handle ssh connects rather the use of passwords.

Here is a quick way to create and set the files directories with the correct permissions.

```bash
mkdir ~/.ssh
chmod  0700 ~/.ssh
chmod  0600 ~/.ssh/id_ed25519
chmod  0644 ~/.ssh/id_ed25519.pub
```

The `id_ed25519` gets used by default if required (may be incorrect)

Key types:

- ed25519 (recommended)
- rsa

```bash
# create a ed25519 ssh key with a password and comment.  An empty
# password for no password
ssh-keygen -t ed25519 -f "$HOME/id_ed25519_name" -C "your comment"
```

Constant password prompts are annoying. Here is how to get rid of them on MacOSX.

```bash
eval $(ssh-agent)
ssh-add --apple-use-keychain
ssh-add --apple-use-keychain ~/.ssh/id_ed25519_your_key
# shortcut if sshkey is setup
for i in $(sshkey list); do ssh-add --apple-use-keychain "$HOME/.ssh/$i"; done
```

On windows run `ssh-agent`

To enable enable logging into a system using your ssh key use `ssh-copy-id`. Here is an example

```bash
ssh-copy-id -i ~/.ssh/id_ed25519_your_key user@remote.com
```

How to add an arbitrary key to a remote server:

```bash
cat ~/.ssh/id_ed25519.pub | ssh username@remote_host "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```
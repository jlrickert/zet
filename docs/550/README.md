# First exploration into Nix

Loosely following the guide from https://github.com/ALT-F4-LLC/kickstart.nix?tab=readme-ov-file#setup-macos not sure what it actually is.

Concepts to learn

- flakes

  Allows version pinning within a lock file

- Nix-command
- /etc/synthetic.conf

  Some mac thing for mounts. Need to explore more

Ran `sh <(curl -L https://nixos.org/nix/install)`. I didn't put in the `--daemon` options so I had to figure out how to uninstall

This ran an interactive prompt. Here is what it will do:

- create system users 302 through 332 and group 30000. Options to tweak using `NIX_FIRST_BUILD_UID`.
- Configure my shell
# Tiling window management in windows with komorebi

A tiling window manager for Windows like i3. Here is an installation attempt
and the things that I tried.

## From source method

- Clone and install [komorebi]

  ```bash
  git clone https://github.com/LGUG2Z/komorebi.git
  ```

- Build and install (Source method)

  Building and installing requires having the rust development toolchain setup
  and ahk installed. May also require dependency on [visual studio] stuff.

  Install with the following

  ```bash
  cargo install --path komorebi --locked
  cargo install --path komorebic --locked
  ```

- Configuration

  Copy over `komorebic.sample.ahk` or [komorebic.ahk] example on github gist.

- Start the process

  ```bash
  komorebic start --await-configuration
  ```

- Stop the process

  ```bash
  komorebic stop
  ```

## Scoop method

The scoop method uses the scoop package manager.

[komorebic.ahk]: https://gist.githubusercontent.com/crosstyan/dafacc0778dabf693ce9236c57b201cd/raw/563a051c18912884bccfe704ea9a412e4c1a3f2e/komorebic.ahk
[komorebi]: https://github.com/LGUG2Z/komorebi
[test]: https://stackoverflow.com/questions/55603111/unable-to-compile-rust-hello-world-on-windows-linker-link-exe-not-found/55603112#55603112

Meta:

    tags: #workstation #rust

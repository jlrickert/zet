# FreeBSD for homelab exploration

FreeBSD has been installed using new enough version of Ventoy. It should be noted that `disc1.iso` should be used as the ISO to use for installation. The usb ones do not work.

FreeBSD has been installed using ventoy. It should be noted that `disc1.iso` should be used as the ISO to use for installation.

Install core DNS for an authoritative DNS

## Log

- `pkg update && pkg install curl fzf git nvim ripgrep starship sudo rsync wget zellij zsh`
- Interactively add user with `adduser`

  Set shell to zsh and add wheel user

- setup sudo with `visudo`. Allow `wheel` group
- sudo ntpdate -v -b in.pool.ntp.org
- `sudo /etc/periodic/weekly/310.locate`
- Install oh my zsh

  ```sh
  scp ~/.zshenv ts140:~/.zshenv
  scp ~/.zshrc ts140:~/.zshrc
  ssh ts140 "cd ~/.local/share && git clone https://github.com/ohmyzsh/ohmyzsh.git oh-my-zsh"
  ssh ts140 "mkdir -p ~/.config/nvim"
  scp -r ~/.config/nvim/ ts140:.config/nvim
  ```

- install node

  ```bash
  sudo pkg install node npm
  mkdir -p ~/.local/share/npm-global
  npm config set prefix '~/.local/share/npm-global'
  ```

- static routing setup

  ```
  sudo sysrc defaultrouter="10.10.0.1"
  sudo systrc ifconfig_em0="inet 10.10.20.81 netmask 255.255.0.0"
  echo "nameserver 127.0.0.1" | sudo tee /etc/resolve.conf
  sudo route add default 10.10.0.1
  ```

- node setup

  I attempted to use `fnm`. However, it was complaining about not being able to find x86 binary node

  ```
  sudo pkg install npm node
  mkdir -p ~/.local/share/npm-global
  npm config set prefix '~/.local/share/npm-global'
  ```

- `pkg install coredns`

  This installs coredns version 1.11.2_3

## CoreDNS

- `/usr/local/etc/coredns/Corefile`

  ```txt
  int.jlrickert.me {
      reload
      log
      errors
      health
      file int.jlrickert.me-zone.txt
  }

  int.ecreativeworks.com {
      reload
      log
      errors
      health
      file int.ecreativeworks.com-zone.txt
  }

  . {
      forward . 8.8.8.8
      log
      errors
      health
      cache
  }
  ```

- `/usr/local/etc/coredns/int.jlrickert.me-zone.txt`

  ```txt
    $TTL    3600
    $ORIGIN int.jlrickert.me.
    @                    IN  SOA   ns.int.jlrickert.me. admin.jlrickert.me. (
                                                   2019121301 ; serial
                                                   1d ; refresh
                                                   2h ; retry
                                                   4w ; expire
                                                   1h ; nxdomain ttl
                                                  )
                         IN  NS     ns.int.jlrickert.me.
    @                    IN  A      192.168.1.12
    *                    IN  A      192.168.1.12
    @                    IN  A      10.10.100.12
    *                    IN  A      10.10.100.12
    php81                IN  A      192.168.0.81
    php74                IN  A      192.168.0.74
    php71                IN  A      192.168.0.71
    mbp                  IN  A      192.168.1.8
    xps                  IN  A      192.168.1.10
    ts140                IN  A      192.168.1.12
  ```

- `/usr/local/etc/coredns/int.ecreativeworks.com-zone.txt`

  ```txt
  $TTL    3600
  $ORIGIN int.ecreativeworks.com.
  @                    IN  SOA   ns.int.ecreativeworks.com. jaredr.ecreative.com. (
                                                 2019121301 ; serial
                                                 1d ; refresh
                                                 2h ; retry
                                                 4w ; expire
                                                 1h ; nxdomain ttl
                                                )
                       IN  NS     ns.int.ecreativeworks.com.
  @                    IN  CNAME  ns.int.jlrickert.me
  jared81              IN  CNAME  php81.int.jlrickert.me
  jared74              IN  CNAME  php74.int.jlrickert.me
  jared71              IN  CNAME  php71.int.jlrickert.me
  ```

## See also

- [Homelab setup](../249)
- [bindzone file RTFM](https://datatracker.ietf.org/doc/html/rfc1035#section-5)
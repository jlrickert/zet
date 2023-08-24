# How to setup HP Officejet j4680 for printing

## Windows

Haven't figured it out yet. I got it to work once. Windows is able to recognize the printer on the network, but doesn't seem to setup the drivers with its automagic.

## Arch linux

Here are the key things that I did to make it work.

Cups is used for a print server. Install and start cups with systemd.

```bash
sudo pacman -Sy cups
systemctl start cups
systemctl enable cups
```

A few extra things that I did that may be needed is adding your user to the usergroup cups. Run `sudo usermod -aG cups jlrickert`. Then restart the cups server through systemd (`sudo systemctl restart cups.service`).

Cups was wasn't able to setup the printer itself. I did find a utility that configured it for me. Use `hp-setup -i`

Another things to note is that the interface for cups (found on localhost:631) uses the users name and password. The user would be `jlrickert` in my case.

## Mac

Works out of the box. No fucking around with stuff.

## See also

- https://wiki.archlinux.org/title/CUPS
- https://wiki.archlinux.org/title/CUPS/Printer-specific_problems#HP

Meta:

    tags: #hardware

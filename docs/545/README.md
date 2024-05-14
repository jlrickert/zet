# How to swap caps lock on windows

The easiest method is the key mapper with power toyz

Swap caps lock with escape

- [ ] TODO: Find a regex hack for swapping caps lock with escape

Swap caps lock with ctrl (have not tried yet)

```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout]
"Scancode Map"=hex:00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00
```

An unofficial explanation can be found at https://www.howtogeek.com/713/disable-caps-lock-key-in-windows/.

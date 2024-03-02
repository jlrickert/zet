# How to increase cursor speed on MacOSX

```bash
defaults read -g InitialKeyRepeat
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
```

```bash
defaults read -g KeyRepeat
defaults write -g KeyRepeat -int 1
```

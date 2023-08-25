# Solution to being locked out of arch linux

At some point while using EndeavourOS on both my desktop and laptop I was locked out from being able to login. I think I traced it down to an issue with yay.

Here is the workaround for now if it happens:

```bash
faillock --user USER --reset
```

This isn't verified yet.

## See also

- [yay issue]: https://github.com/Jguer/yay/issues/2170

## Meta

    tags: #linux

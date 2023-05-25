# Managing personal secrets with an external USB drive

An effective way for managing private data between systems is to use a USB
stick. In order to be effective it needs to be compatible with all the systems
you intend to use. This requires the right formatting and optionally a way to
encrypt/decrypt the data.

For use with MacOS, Linux, WSL, Windows and Android, the recommended format is
exFAT. If you need more compatibility go with FAT.

Encryption could be done with EncFS. Eventually, I plan on looking at
encrypting.

This is the way I have things structured

- A bare git repository `repos/priv.git` that stores all my certs, keys, and
  private scripts
- A bare git repository for my private git repos such as a `zet` repo

Meta:

    #lifehacks #git #tips

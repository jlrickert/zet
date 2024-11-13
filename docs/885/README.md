# SPEC: encode bash script

A simple bash script to encode text strings into some formats

Supported formats:

- base64url
- base64
- url

  Remove invalid characters. For example spaces become the right thing

## CLI Interface

```
encode base64url "Here is some example" # outputs ...
```

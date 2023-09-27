# How do you fingerprint the OS with bash

Being able to detect what environment is problem that comes up often. It is a
requirement when writing install scripts that need to support multiple
environments. Some environments include: MacOS, Debian, Ubuntu, Arch, Windows,
WSL 1, WSL 2, and different CI/CD environments.

- Detect if running in WSL

  ```bash
  if [[ "$(uname -r)" =~ Microsoft ]]; then
  fi

  # Untested
  if grep -q -i microsoft /proc/version; then
  fi
  ```

- Detect if running in MacOSX

  ```bash
  if [[ "$(uname -r)" =~ Darwin ]]; then
  fi
  ```

Meta

      tags: #bash #cli

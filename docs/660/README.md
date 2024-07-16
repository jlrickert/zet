# Overview: Bash scripting

## Script template

```bash
#!/usr/bin/env bash

set -o errexit  # exit if non-zero status code is returned
set -o nounset  # exit if undefined variable is used
set -o pipefail # exit if no-zero status code is returned in a pipeline

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
```

> [!NOTE]
>
> Don't use env if you don't have to. [MacOSX](../654) is stupid. Prefer `#!/bin/bash` See [rwxrob](../80) personal [keg](../651) on reasons why.

## See also

- [Context Management](../113)

  This plays a role with package management

- [Os fingerprinting](../133)
- [export PATH trick](../655)
- [Bash completions](../125)

## Handy executables

- [`entr`](../679)
- [`rsync`](../680)

## Integrations

- [reusable SQL script](../652) with [mariadb](../654)
# Managing contexts with bash

Homebrew bootstraps itself with `source <(/opt/homebrew/bin/brew
shellenv)`

Here is a similar thing that I have come up with. Here is my `shellenv`
bash script.

```bash
#!/bin/bash

set -o errexit  # exit if non-zero status code is returned
set -o nounset  # exit if undefined variable is used
set -o pipefail # exit if no-zero status code is returned in a pipeline

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
SCRIPT=$(
    cat <<-EOF
export PATH="${PATH}:${SCRIPT_DIR}/bin"
EOF
)

echo -e "${SCRIPT}"
```

This may be sourced with `source <(/path/to/shellenv)`. This is a work
around for the fact that a subshell is not able to modify the caller.
This allows the shellenv script to have the environment that we expect.

Meta:

    tags: #bash #cli

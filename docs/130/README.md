# How to configure bash scripting behavior

Here are some of the long form options that I know of.

```bash
set -o errexit  # exit if non-zero status code is returned
set -o nounset  # exit if undefined variable is used
set -o pipefail # exit if no-zero status code is returned in a pipeline
```

For more in depth information read the bash [docs] about the built in
set command.

[docs]: https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html

    #bash #cli

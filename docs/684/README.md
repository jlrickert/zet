# Colors in bash scripting

```bash
NOCOLOR=${NOCOLOR:-}
[[ -t 1 ]] || NOCOLOR=y
declare GOLD='[38;2;184;138;0m'
declare RED='[38;2;255;0;0m'
declare GREY='[38;2;100;100;100m'
declare CYAN='[38;2;0;255;255m'
declare GREEN='[38;2;0;255;0m'
declare RESET='[0m'

if [[ -n "${NOCOLOR}" ]] ; then
echo true
  GOLD=
  RED=
  GREY=
  CYAN=
  GREEN=
  RESET=
fi
```

Example usage:

```bash
echo "${GOLD}some goldtext${RESET}"
echo "regular text"
echo "${GREEN}this is green${RESET}and${RED}this is red${RED}"
```

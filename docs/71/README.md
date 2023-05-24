# How to handle conditionals in bash scripting

```bash
# Test if variable is not set
if [[ -z "$xyz" ]]; then
    ...
fi
``


# test if a command doesn't exist
if ! command -v command &> /dev/null; then
    ...
fi

# another approach test if a command doesn't exist
if ! which command &> /dev/null; then
    ...
fi

# Run if directory is found
test -d build && rm -r build/

# Run if directory is found
test -d build || rm -r build/

# Using regex to test if it is a text file
FILE="$(which "$1")"
if ! [[ "$(file "${FILE}")" =~ ASCII ]]; then
    exit
fi
```

    #cli #bash

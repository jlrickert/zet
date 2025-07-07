# How to handle conditionals in bash scripting

```bash
# Test if variable is not set or empty
if [[ -z "$xyz" ]]; then
    echo "Variable xyz is empty or not set"
fi

# Test if a variable is set and not empty
if [[ -n "$my_variable" ]]; then
    echo "Variable my_variable is set and not empty"
fi

# Test if two strings are equal
if [[ "$string1" == "$string2" ]]; then
    echo "Strings are equal"
fi

# Test if two strings are not equal
if [[ "$string1" != "$string2" ]]; then
    echo "Strings are not equal"
fi

# Test if two numbers are equal
if [[ "$num1" -eq "$num2" ]]; then
    echo "Numbers are equal"
fi

# Test if first number is greater than second
if [[ "$num1" -gt "$num2" ]]; then
    echo "num1 is greater than num2"
fi

# Test if first number is less than or equal to second
if [[ "$num1" -le "$num2" ]]; then
    echo "num1 is less than or equal to num2"
fi

# test if a command doesn't exist (using command -v)
if ! command -v command &> /dev/null; then
    echo "command does not exist"
fi

# another approach test if a command doesn't exist (using which - generally older)
if ! which command &> /dev/null; then
    echo "command does not exist"
fi

# Run if directory is found (using test command and && for AND)
test -d build && rm -r build/ # If build directory exists, remove it

# Run if directory is NOT found (using test command and || for OR)
test -d build || mkdir build/ # If build directory does NOT exist, create it

# Test if a file exists (-f)
if [[ -f "/path/to/file.txt" ]]; then
    echo "File exists"
fi

# Test if a directory exists (-d) - already shown, adding for completeness
if [[ -d "/path/to/directory" ]]; then
    echo "Directory exists"
fi

# Test if a file is readable (-r)
if [[ -r "/path/to/file.txt" ]]; then
    echo "File is readable"
fi

# Test if a file is writable (-w)
if [[ -w "/path/to/file.txt" ]]; then
    echo "File is writable"
fi

# Test if a file is executable (-x)
if [[ -x "/path/to/script.sh" ]]; then
    echo "Script is executable"
fi

# Test if it is a text file using regex with [[ ]]
FILE="$(which "$1")"
if ! [[ "$(file "${FILE}")" =~ ASCII ]]; then
    echo "$1 is not an ASCII file"
    exit 1 # Exit with an error code
fi

# Combine conditions using && (AND) in [[ ]]
if [[ -f "/path/to/file.txt" && -w "/path/to/file.txt" ]]; then
    echo "File exists and is writable"
fi

# Combine conditions using || (OR) in [[ ]]
if [[ -f "/path/to/file.txt" || -d "/path/to/directory" ]]; then
    echo "File exists or directory exists"
fi

# Using a case statement for multiple distinct conditions
case "$my_variable" in
    "value1")
        echo "Variable is value1"
        ;;
    "value2" | "value3") # Multiple patterns for one case
        echo "Variable is either value2 or value3"
        ;;
    *) # Default case
        echo "Variable is something else"
        ;;
esac
```

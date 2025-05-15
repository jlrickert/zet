# Terminal color

## Color palettes

- [Gogh color scheme palettes](https://github.com/Gogh-Co/Gogh)

## Bash Terminal Color Codes (ANSI Escape Sequences)

These codes are used with `echo -e` or similar commands to format terminal output.

### Text Attributes

- `\033[0m` - Reset/Normal (Turns off all attributes)
- `\033[1m` - Bold/Bright
- `\033[4m` - Underline
- `\033[5m` - Blink (Often not supported or ignored by terminals)
- `\033[7m` - Invert/Reverse (Swaps foreground and background color)
- `\033[8m` - Hidden/Invisible
- `\033[21m` - Bold off
- `\033[24m` - Underline off
- `\033[25m` - Blink off
- `\033[27m` - Reverse off
- `\033[28m` - Hidden off

### Foreground Colors

- `\033[30m` - Black
- `\033[31m` - Red
- `\033[32m` - Green
- `\033[33m` - Yellow
- `\033[34m` - Blue
- `\033[35m` - Magenta
- `\033[36m` - Cyan
- `\033[37m` - White
- `\033[39m` - Default foreground color

### Bright Foreground Colors

(Combine `1m` for Bold/Bright attribute with standard color codes)

- `\033[1;30m` - Bright Black (Often appears as Gray)
- `\033[1;31m` - Bright Red
- `\033[1;32m` - Bright Green
- `\033[1;33m` - Bright Yellow
- `\033[1;34m` - Bright Blue
- `\033[1;35m` - Bright Magenta
- `\033[1;36m` - Bright Cyan
- `\033[1;37m` - Bright White

### Background Colors

- `\033[40m` - Black background
- `\033[41m` - Red background
- `\033[42m` - Green background
- `\033[43m` - Yellow background
- `\033[44m` - Blue background
- `\033[45m` - Magenta background
- `\033[46m` - Cyan background
- `\033[47m` - White background
- `\033[49m` - Default background color

### Bright Background Colors

(These are separate codes, not typically achieved by combining `1m` with standard backgrounds)

- `\033[100m` - Bright Black background
- `\033[101m` - Bright Red background
- `\033[102m` - Bright Green background
- `\033[103m` - Bright Yellow background
- `\033[104m` - Bright Blue background
- `\033[105m` - Bright Magenta background
- `\033[106m` - Bright Cyan background
- `\033[107m` - Bright White background

---

**Example Usage:**

```bash
echo -e "\033[41;37m White text on Red background \033[0m"
echo -e "\033[1;32m This is bold green text\033[0m"
```

Remember to always end your colored text with `\033[0m` to reset the attributes, otherwise, subsequent text in your terminal might inherit the formatting.

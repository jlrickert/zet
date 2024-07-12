# Programmatic bash completions

- `inputrc`

Relevant variables:

| Variable     | Description                                                        |
| ------------ | ------------------------------------------------------------------ |
| `COMREPLY`   | An array to push to for options that are available for completions |
| `COMP_WORDS` | an array of all the words typed after the name of the program      |
| `COMP_LINE`  | the current command line                                           |

`complete options`:

| Option        | name        | Description            |
| ------------- | ----------- | ---------------------- |
| `-o` _option_ | comp-option |                        |
| `-C`          |             | Executed in a Subshell |
| `-c`          |             |                        |

Overall this is my preferred way to do bash completions

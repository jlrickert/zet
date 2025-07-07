# Programmatic bash completions

Opinionated way to do completions in bash. Completions are located in the script itself

- `inputrc`

Relevant variables:

| Variable     | Description                                                        |
| ------------ | ------------------------------------------------------------------ |
| `COMPREPLY`  | An array to push to for options that are available for completions |
| `COMP_WORDS` | an array of all the words typed after the name of the program      |
| `COMP_LINE`  | the current command line                                           |

`complete options`:

| Option        | name        | Description            |
| ------------- | ----------- | ---------------------- |
| `-o` _option_ | comp-option |                        |
| `-C`          |             | Executed in a Subshell |
| `-c`          |             |                        |

Overall this is my preferred way to do bash completions

## Enabling completions

For bash I use all you need to do is `complete -C prog prog` where prog is a program found within your path.

## Example

Okay, here is a Bash script example using `zet` as the command name, demonstrating completion detection with `COMP_LINE` and exiting early.

Okay, here are two Bash script examples (`ku` and `zet`), demonstrating completion handling using the `COMP_LINE` environment variable for detection. As requested, the `complete` command itself is *not* in the scripts and needs to be run in your shell session. The scripts will echo the suggested completions to standard output and exit early when `COMP_LINE` is set.

This approach requires the shell's `complete -C` to do the final filtering based on what the user has typed (`$cur`).

**1. Simple Example (`ku`) - `ku.sh`:**

This script provides a fixed list of directions (`up`, `down`, `left`, `right`) for completion.

```bash
#!/bin/bash

# This is the script 'ku.sh'

# --- Completion Detection and Handling ---

# Check if the COMP_LINE environment variable is set.
# This variable is set by the shell's 'complete' built-in when it calls
# this script to get completion candidates. If it's set (non-empty),
# we know we are in a completion context.
if [[ -n "$COMP_LINE" ]]; then
    # We are in completion mode.

    # Define the full list of possible completion words.
    # These are the suggestions we want to offer.
    local completion_words="up down left right forward backward"

    # We don't need to parse COMP_WORDS or COMP_CWORD directly here
    # if we rely on 'complete -C' to do the filtering.
    # We just echo the full list of possibilities relevant to *some* context
    # and let compgen/complete filter it.

    # Echo the list of possible words, separated by spaces or newlines.
    # Bash's 'complete -C' expects words on standard output.
    echo "$completion_words"

    # Exit immediately after providing the completion list.
    exit 0
fi

# --- Normal Command Execution (if not in completion mode) ---

# If COMP_LINE was NOT set, the script proceeds here to execute the command logic.
echo "--- Running the actual ku command ---"
echo "Arguments received: $@"

# Placeholder for your actual command logic
case "$1" in
    up)    echo "Moving up!" ;;
    down)  echo "Moving down!" ;;
    left)  echo "Turning left." ;;
    right) echo "Turning right." ;;
    *)
        echo "Unknown direction: $1"
        echo "Usage: ku <up|down|left|right>"
        exit 1
esac

exit 0
```

**2. Delegation Example (`zet`) - `zet.sh`:**

This script provides different completion suggestions based on whether you're completing the first argument (subcommand) or a subsequent argument (like a note ID after `view` or `link`). This *does* require looking at `COMP_CWORD` and `COMP_WORDS` to understand the *context* of the completion, even if we don't use `COMPREPLY`.

```bash
#!/bin/bash

# This is the script 'zet.sh'

# --- Completion Detection and Handling ---

# Check if we are being invoked by Bash's completion system.
if [[ -n "$COMP_LINE" ]]; then
    # We are in completion mode.
    # (Optional) Uncomment for debug:
    # echo "DEBUG: COMP_LINE='$COMP_LINE', POINT='$COMP_POINT', CWORD='$COMP_CWORD'" >/dev/stderr
    # echo "DEBUG: WORDS='${COMP_WORDS[@]}'" >/dev/stderr

    local cur prev

    # Get the current word being completed
    cur="${COMP_WORDS[COMP_CWORD]}"
    # Get the word immediately before the current word, if one exists
    if [[ "$COMP_CWORD" -gt 0 ]]; then
      prev="${COMP_WORDS[COMP_CWORD-1]}"
    else
      prev="" # No previous word if completing the first arg
    fi

    # --- Define possible completion candidates (static lists for this example) ---
    local subcommands="create view search link update delete"
    # Example IDs and aliases from your KEG, simulate this being dynamic
    local keg_candidates="0 16 35 459 887 921 keg-intro bash-guide dotfiles homelab neovim-editor my-project keg-specifications"

    # --- Determine which list of suggestions to provide based on context ---

    local suggestions=""

    # Context 1: Completing the first argument (the subcommand)
    # If COMP_CWORD is 1, the previous word (COMP_WORDS[0]) is the command name ('zet')
    if [[ "$COMP_CWORD" -eq 1 ]]; then
        suggestions="$subcommands"
    # Context 2: Completing an argument after 'view', 'link', 'update', or 'delete'
    # Check the previous word ($prev)
    elif [[ "$prev" == "view" || "$prev" == "link" || "$prev" == "update" || "$prev" == "delete" ]]; then
        suggestions="$keg_candidates"
    # Add more elif cases for other contexts if needed (e.g., args after 'search')

    # Default: If no specific context is matched, provide general candidates or nothing
    # (For this example, we'll provide nothing if the context isn't recognized)
    # else
    #    suggestions="$keg_candidates" # Could fallback to general keg items
    fi

    # --- Output the suggestions ---
    # compgen filters the list ($suggestions) based on the current input ($cur)
    # compgen -W "$suggestions" -- "$cur" outputs results relevant to $cur prefix
    # We echo these results directly for 'complete -C'
    echo "$(compgen -W "$suggestions" -- "$cur")"

    # Exit immediately after providing the list.
    exit 0
fi

# --- Normal Command Execution (if not in completion mode) ---

# If COMP_LINE was NOT set, the script proceeds here to execute the command logic.
echo "--- Running the actual zet script ---"

# Access command-line arguments passed by the user
COMMAND="$1"
shift # Remove subcommand
ARGS=("$@") # Remaining arguments

echo "Subcommand: '$COMMAND'"
echo "Remaining Arguments: '${ARGS[@]}'"

# Placeholder logic for your command execution
case "$COMMAND" in
    create) echo "Action: Creating..." ;;
    view) echo "Action: Viewing ${ARGS[0]}..." ;;
    search) echo "Action: Searching for ${ARGS[@]}..." ;;
    link) echo "Action: Linking ${ARGS[@]}..." ;;
    update) echo "Action: Updating ${ARGS[0]}..." ;;
    delete) echo "Action: Deleting ${ARGS[0]}..." ;;
    *)
        if [[ -z "$COMMAND" ]]; then
            echo "No subcommand provided."
        else
            echo "Unknown subcommand: $COMMAND"
        fi
        echo "Usage: zet <subcommand> [args...]"
        exit 1
esac

exit 0
```

**How to Use Both Examples:**

1.  **Save the scripts:** Save the first code block as `ku.sh` and the second as `zet.sh`.
2.  **Make them executable:**
    ```bash
    chmod +x ./ku.sh
    chmod +x ./zet.sh
    ```
3.  **Register the scripts for completion (`in your shell session`):**
    ```bash
    # Register ku:
    complete -C "./ku.sh" ku

    # Register zet:
    complete -C "./zet.sh" zet
    ```
    *(To make these persistent across shell sessions, add the `complete` lines to your `~/.bashrc` or similar shell configuration file).*
4.  **Test completion for `ku`:**
    *   Type `ku ` (with a space) and press Tab. You should see `backward forward down left right up`.
    *   Type `ku d` and press Tab. It should show `down`. Type Tab again to select or complete.

5.  **Test completion for `zet`:**
    *   Type `zet ` (with a space) and press Tab. You should see `create delete link search update view`. (These are the `subcommands`).
    *   Type `zet v` and press Tab. It should complete to `zet view`.
    *   Type `zet view ` (with a space) and press Tab. You should then see the list of `keg_candidates` like `0 16 35 459 887 921 bash-guide dotfiles ...`.
    *   Type `zet link ` (with a space) and press Tab. You should also see the `keg_candidates` list again.
    *   Type `zet link 16 ` (with a space) and press Tab. For this simple example, it will fall back to default completion (like files/directories) because we didn't add logic for arguments *after* the first one for view/link/update/delete. In a real application, you'd add more `elif` checks based on `COMP_CWORD` and preceding words to offer relevant suggestions (e.g., tags, filenames, etc.).

6.  **Test normal execution:**
    *   Type `ku right` and press Enter.
    *   Type `zet view 921` and press Enter.
    *   Type `zet unknown_command test` and press Enter.

Notice that when you press Tab, you only see the output relevant to completion (the lists). When you press Enter, you see the "--- Running the actual... ---" message and the command's normal output.



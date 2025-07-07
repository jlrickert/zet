# Stateful command tree design architecture

An opinionated way to structure composable command line applications.

- Program includes the completions in the binary or script rather than external
- Program options are passed in through state rather than options
- Command tree is a sequence of subcommands with a given set of arguments
- Command tree may be dynamically generated from the root down

## Examples

Some examples include many of my scripting utilise that use this structure and have [completions](../125):

- [ku](https://github.com/jlrickert/dotfiles/blob/dev/pkg/shell/bin/ku)
- [zet](https://github.com/jlrickert/dotfiles/blob/dev/pkg/shell/bin/zet)

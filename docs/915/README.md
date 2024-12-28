# Issue: unable to change model of an ongoing `mods` conversation

The [`mods`](../915) command has been observed to exhibit a bug where users are unable to change the model once a conversation title has been established. I discovered this limitation while working on my [dotfiles](../625) project, which can hinder flexibility for users attempting to switch models based on evolving needs during a session.

## Steps to Reproduce

1. Execute the `mods` command to set a conversation title, e.g.:

   ```bash
   mods --api openai --model gpt-4o --title "example_title"
   ```
2. Attempt to change the model after the title has been set by executing a command like:

   ```bash
   mods --api openai --model gpt-4 --continue "example_title"
   ```
3. Observe that the model does not change, and the command continues to use the initially set model.

## Expected Behavior

Users should be able to change the model at any point during the conversation, even after a title has been established. This flexibility allows for more tailored interactions with the AI, enabling users to select the most appropriate model for their requirements.

## Actual Behavior

Once the title is set, any attempts to modify the model yield no effect; the conversation continues under the previously defined model, limiting user adaptability.

## Impact

This bug restricts the usability of the `mods` command and can lead to frustration for users who expect to have the ability to dynamically switch models during their interactions. Addressing this issue would enhance the user experience by providing greater control over AI model selection throughout a session.

## Proposed Solution

- Refactor the internal logic of the `mods` command to separate the model selection from the title management, allowing users to update the model independently at any point.
- Implement validations that inform users when a model change is ignored or denied, providing clarity on the command's behavior.

This summarizes the issue related to the inability to change the model after setting a conversation title within the `mods` command.

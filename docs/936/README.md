# Prompt: Instructions for commenting code

## How to Comment Code

1. **Determine Purpose**: Identify the main purpose of the function or code block.
2. **Select Comment Style**: Use the appropriate syntax for the programming language (e.g., // for single-line, /_ ... _/ for multi-line).
3. **Write a Brief Description**: Summarize what the function does without detailing implementation.
4. **Use Docblock Format**: For functions, include a docblock with a brief description, parameters, and return values if applicable.
5. **Preserve Indentation**: Maintain the same indentation level as the code.
6. **Avoid Redundancy**: Exclude information that can be inferred from the code.
7. **Ensure Valid Output**: Make sure the comment format is valid for the specific programming language.
8. **Preserve Function Contents**: Ensure the function’s contents remain unchanged. It should be placed directly below the comment. It should not trigger a git diff.
9. **Output Should Be Valid for the Language**: Ensure that the comment and any related syntax conform to the requirements of the programming language being used.
10. **Side effects:** All side effects should be documented
11. **Output** Output should add the comment directly to the code. No additional markup

Output should include should include the contents unchanged with additional code comments included.
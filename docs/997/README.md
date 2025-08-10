# LLM modal comparison for use with mods (2025-04-17)

Available models may be found in the [config template] on GitHub.

[config template]: https://github.com/charmbracelet/mods/blob/main/config_template.yml

- [OpenAI pricing](https://platform.openai.com/docs/pricing)

## Comparison

| Model        | Input | Cached input | Output |
| ------------ | ----- | ------------ | ------ |
| gpt-4o-mini  | $0.15 | $0.075       | $0.60  |
| gpt-4.1-nano | $0.10 | $0.025       | $0.40  |
| gpt-4.1-mini | $0.40 | $0.10        | $1.60  |

Here's the normalized table combining both pricing structures:

| Model             | Base Input   | Cached Input (5m) | Cached Input (1h) | Cache Hits/Refreshes | Output       |
| ----------------- | ------------ | ----------------- | ----------------- | -------------------- | ------------ |
| **OpenAI Models** |
| gpt-4o-mini       | $0.15 / MTok | $0.075 / MTok     | -                 | -                    | $0.60 / MTok |
| gpt-4.1-nano      | $0.10 / MTok | $0.025 / MTok     | -                 | -                    | $0.40 / MTok |
| gpt-4.1-mini      | $0.40 / MTok | $0.10 / MTok      | -                 | -                    | $1.60 / MTok |
| **Claude Models** |
| Claude Opus 4.1   | $15 / MTok   | $18.75 / MTok     | $30 / MTok        | $1.50 / MTok         | $75 / MTok   |
| Claude Opus 4     | $15 / MTok   | $18.75 / MTok     | $30 / MTok        | $1.50 / MTok         | $75 / MTok   |
| Claude Sonnet 4   | $3 / MTok    | $3.75 / MTok      | $6 / MTok         | $0.30 / MTok         | $15 / MTok   |
| Claude Sonnet 3.7 | $3 / MTok    | $3.75 / MTok      | $6 / MTok         | $0.30 / MTok         | $15 / MTok   |
| Claude Sonnet 3.5 | $3 / MTok    | $3.75 / MTok      | $6 / MTok         | $0.30 / MTok         | $15 / MTok   |
| Claude Haiku 3.5  | $0.80 / MTok | $1 / MTok         | $1.6 / MTok       | $0.08 / MTok         | $4 / MTok    |
| Claude Opus 3     | $15 / MTok   | $18.75 / MTok     | $30 / MTok        | $1.50 / MTok         | $75 / MTok   |
| Claude Haiku 3    | $0.25 / MTok | $0.30 / MTok      | $0.50 / MTok      | $0.03 / MTok         | $1.25 / MTok |

**Key Changes:**

- Unified column headers across both pricing structures
- Added model family groupings for clarity
- Standardized pricing format to "$ / MTok" throughout
- Added dashes (-) for unavailable pricing tiers in OpenAI models
- Maintained all original pricing data while improving readability

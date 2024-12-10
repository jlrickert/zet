# Experimenting with AI context windows on LocalAI and OpenAI

Typically, I use the [`mod`] program and a couple of scripts around my `zet` script to selectively feed the model **KEG** nodes to provide additional context for the AI to answer back. LocalAI offers a way to instead run on local hardware rather an OpenAI. Here is what I found out:

- Costs roughly 1$ per 20 nodes on OpenAI
- Expect up to 5 seconds per node as OpenAI has limits on its API.
- LocalAI is roughly 4x slower on my [mac](../583) (`gpt-4o` vs `qwen2.5-coder-32b-instruct`)
- LocalAI is a PITA to setup on windows. Couldn't figure out how to get it to work with a 1060 GPU for the given amount of time I wanted to spend on it.
- Able to install from brew. `brew install localai`. Image generation TTS and Talk don't seem to work. Compiling locally doesn't work.
- `localai` crashes and stops working after like 80 nodes or so

[`mod`](https://github.com/charmbracelet/mods)

## Local AI setup

How I setup localai on my [mac](../583)

```bash
brew install localai
mkdir -p "${HOME}/.local/share/localai"
cd "${HOME}/.local/share/localai"
local-ai # runs local-ai
```

Once localai is running go to models and download the models.

I added `"${HOME}/.local/share/localai"` to the excludes list for time machine as it takes up a ton of space. I could just re download them from the internet.

## `mods` setup

The application that I use for consuming chatgpt's APIs is `mods`. Easy to install with `brew install mods`.

Key points about mods:

- mods alias don't seem to work. Need to use the full model name (e.g. `qwen2.5-coder-32b-instruct`)
- localai models need to be added to `mods.yaml` (located at `${HOME}/.config/mods/mods.yml`)

I created a wrapper script around `mods` called [`nexi`](../889). It simply tells mods to use either `qwen2.5-coder-32b-instruct` on localai instead of `gpt-4o` on openai. An example of the call to mods is `mods -m "qwen2.5-coder-32b-instruct" -t "nexi" -c "nexi" "your message"` to use localai instead of openai. These models need to be available in `mods.yml` (located at `${HOME}/.config/mods/mods.yml`).

```yaml
apis:
  openai:
    openai:
    base-url: https://api.openai.com/v1
    api-key:
    api-key-env: OPENAI_API_KEY
    models:
      gpt-4o:
        aliases: ["4o"]
        max-input-chars: 392000
        fallback: gpt-4
      gpt-4:
        aliases: ["4"]
        max-input-chars: 24500
        fallback: gpt-3.5-turbo
  localai:
    # LocalAI setup instructions: https://github.com/go-skynet/LocalAI#example-use-gpt4all-j-model
    base-url: http://localhost:8080
    models:
      qwen2.5-coder-32b-instruct:
        aliases: ["gwen32b"]
        max-input-chars: 12800
        fallback:
      qwen2.5-coder-3b-instruct:
        aliases: ["gwen3b"]
      qwen2.5-72b-instruct:
        aliases: ["gwen"]
```

# Patch make ed get edit's zsh completions (temporary hack)

Quick hacky patch to my installed [dotfiles](../221) on my [macOS](../654).

Purpose

- Short-term hack so the CLI program `ed` receives the same zsh completions as
  `edit`.
- Not intended as a permanent system change. Documented here so you can
  reproduce or revert.

Environment / context

- Commands were done from your shell history on [macOS/Linux](../109) (example snippet
  shown in history).
- Completions live in your [zsh](../69) completion directory (in your [dotfiles](../221) cache:
  `~/.cache/dotfiles/zsh/completions` in your case).
- [zsh](../69) caches compiled completions at `~/.zcompdump`; removing it forces [zsh](../69) to
  regenerate completions.

What I did (commands I ran)

- Checked which `ed` and `edit` executables are used:
  ```
  which ed
  which edit
  ```
- Copied the `edit` binary over the `ed` binary (this replaces `ed` with
  `edit`):
  ```
  cp $(which edit) $(which ed)
  ```
  Note: this is destructive if `which ed` points at a real system `ed`. See
  revert below.
- Worked in the completion directory and duplicated `_edit` to `_ed`:
  ```
  cd ~/.cache/dotfiles/zsh/completions
  ls
  cp _edit _ed
  ```
- Edited the new `_ed` completion (I used `ed` to open/edit it):
  ```
  ed _ed
  ```
  (Inside that edit I used [sed](../33)-like changes — see recommended [sed](../33) below.)
- Removed the [zsh](../69) completion dump so [zsh](../69) will rebuild completions:
  ```
  rm ~/.zcompdump
  ```
  Then either restart the shell or re-run `compinit` / `exec zsh` to rebuild
  completions.

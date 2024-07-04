# Task to figure out how to make scrolling faster on MacOS

For some reason holding _j_ doesn't behave as expected. I am expecting
to continuously move down as I hold it.

I found an [issue] on GitHub that sounds like the one that I am having.

Tried running this from the comments about the [issue] but no luck.
Have not tried restarting anything after running though.

```bash
defaults write com.Microsoft.VisualStudioCode ApplePressAndHoldEnabled -bool false
```

[issue]: https://github.com/VSCodeVim/Vim/issues/345

- [ ] TODO: fix j behavior on MacOS for VSCode

Meta:

    tags: #fixme #macOS #vscode #programming
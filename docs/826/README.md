# Trick: pulling in a commit from upstream with git

Pulling in a commit from upstream is a bit problematic as there typically will be lots of merge conflicts. You could cherry pick it. However, this usually brings in extra crap. I found that using git show and apply tends to work better. The 3way is way to get around the patch not applicable issue.

- `git remote upstream-name git@example.com:repo_name.git`
- `git fetch upstream-name`
- `git show abc123 | git apply --3way`


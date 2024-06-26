# Git techniques and cheat sheet

- Interactive add hunks to a commit:

  Run `git add -i`. What you want to do is patch. Enter the numbers of the files
  to patch. This allows you to select specifically what you want to include in
  your next commit.

- Undo the last commit and place them as unstaged commits

  Run `git reset HEAD^`. If you run git status right after you should should see
  the items show as unstaged in the status

- Pulling in files from upstream

  Run `git pull upstream --rebase`. This will add the upstream changes to you
  repo before your commits.

- Check for secrets commited

  `git grep 'YOUR_SECRET` "$(git rev-list --all)"

  `git log -S 'YOUR_SECRET' --oneline --name-only --pretty=format:'%h %s'`

## See also

- https://rtyley.github.io/bfg-repo-cleaner/

## Meta

    #cli #linux #git #unix

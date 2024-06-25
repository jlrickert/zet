# Git techniques and cheatsheet

- Interactive add hunks to a commit:

  Run `git add -i`. What you want to do is patch. Enter the numbers of the files to patch.

- Undo the last commit and place them as unstaged commits

  Run `git reset HEAD^`. If you run git status right after you should should see the items show as unstaged in the status

- Pulling in files from upstream

  Run pull with the -r flag to signal a rebase. This will apply the patches from upstream and then apply your commits on top of them.

- Delete all files not tracked by git

  Run `git clean -dfx`

- Rebasing branch comments on different branch

  ```bash
  git checkout main
  git pull origin main
  git checkout my_branch
  git rebase production
  git checkout production
  git merge --ff my_branch
  ```

- Set current branch to what is on remote

  ```bash
  git checkout <git commit hash>
  git checkout -B your_branch
  ```

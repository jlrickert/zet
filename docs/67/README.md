# My first user experience with keg

So far keg seems promising. I haven't really read much of the documentation
much and only have really been poking around with documentation provided by keg
in the bonzai tree.

I keep running into the following error

```
error: cannot pull with rebase: You have unstaged changes.
error: please commit or stash them.
No remote repo has been setup. First create it and git push to it.
```

After some digging it turns out that in `.git/config` there is an option
`rebase = true`. Removing this line solved the issue.

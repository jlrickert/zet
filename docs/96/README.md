# keg create git issue

An issue where keg complains about not being able to pull with a rebase.

```
error: cannot pull with rebase: You have unstaged changes.
error: please commit or stash them.
No remote repo has been setup. First create it and git push to it.
```

When `keg edit` or `keg create` is called the keg indexes are updated
and a few git commands are run.
From the code base of keg these git commands invoked from `keg
edit` or `keg create`.

The following git commands are run after a new is created and the dex is updated.

- `git -C kegpath pull`
- `git -C kegpath add -A .`
- `git -C kegpath commit -m ???`
- `git -C kegpath push`

The `-C` option is the working directory to use. `kegpath` is the git directory.

## Solution

`rebase` is set to true in `.git/config`. This needs to be removed.

Meta:

    #issue #solved

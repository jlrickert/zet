# A nifty way to compare versions

I ran into this snippet of code while create a bash script the check if I had a 
new enough version of `fzf`.

```bash
_version_ge()
{
    printf '%s\n%s\n' "$2" "$1" | sort --check=quiet --version-sort
}

_version_ge "${VERSION}" "0.42.0" && echo "yes
```

    tags: #bash #cli

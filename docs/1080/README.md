# Trick: Alt pipelines in bash

I discovered a trick on how to do alt pipelines in bash:

Here is an example:

```bash
KEG_CURRENT="${KEG_CURRENT:-""}"
# Try KEG_CURRENT if defined
if [ -n "$KEG_CURRENT" ]; then
	:
# Try fd to find the keg docs directory
elif KEG_CURRENT="$(fd keg --absolute-path)"; then
	KEG_CURRENT="$(dirname $KEG_CURRENT)"
# Try git project docs directory
elif KEG_CURRENT="$(git rev-parse --show-toplevel)"; then
	KEG_CURRENT="${KEG_CURRENT}/docs"
else
	echo "No KEG found"
fi
```

# Patch: Add fzf to ku script

A patch to my [dotfiles](../625) `ku` script.

## Patch

This patch introduces a new subcommand `fzf` to the `ku` shell script. The `fzf` subcommand enables interactive fuzzy searching and selection of items from a list, with a preview feature that shows the first heading and content of a corresponding README file for the selected item. After selecting an item via the `fzf` interface, the patch automatically triggers the item's editing command. This addition enhances usability by providing a quick, interactive way to find and edit items within the tool. The patch replaces previously commented-out experimental code with a clean implementation and integrates the new `_ku_fzf` function as a recognized subcommand.

```gitdiff
commit 8e3e46497949c173d3927a0de55f39ad30808758
Author: Jared Rickert <jaredrickert52@gmail.com>
Date:   Sat Jul 26 11:54:24 2025 -0500

    feat: add fzf subcommand for interactive item selection and editing

    Introduce a new fzf subcommand to enable fuzzy searching through items
    with preview support. This improves usability by allowing quick
    selection and editing of items via an interactive interface.

diff --git a/pkg/00_shell/bin/ku b/pkg/00_shell/bin/ku
index be5f329..e5bfc68 100755
--- a/pkg/00_shell/bin/ku
+++ b/pkg/00_shell/bin/ku
@@ -229,21 +229,16 @@ _ku_edit() {
 	keg edit "$@"
 }

-	# # shellcheck disable=SC2034
-	# FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" fzf \
-	#     --bind "change:reload:$RG_PREFIX {q} || true" \
-	#     --sort \
-	#     --preview 'echo -n {1} " "; rg "^#" docs/{1}/README.md --no-heading | head -n 1;bat --style "grid,numbers,snip" --color=always --paging never docs/{1}/README.md' \
-	#     --height=100% \
-	#     --width=80% \
-	#     --ansi --phony --query "$INITIAL_QUERY" "$@"
-	#
-	# FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" fzf \
-	#     --bind "change:reload:$RG_PREFIX {q} || true" \
-	#     --sort \
-	#     --preview 'echo -n {1} " "; rg "^#" docs/{1}/README.md --no-heading | head -n 1;bat --style "grid,numbers,snip" --color=always --paging never docs/{1}/README.md' \
-	#     --height=100% \
-	#     --ansi --phony --query "$INITIAL_QUERY" "$@"
+_ku_fzf() {
+	local item_list=$(_ku_list | awk '{print $1}')
+	local item
+	item=$(
+		_ku_list | fzf \
+			--bind "change:reload:ku list" \
+			--preview 'echo -n {1} " "; rg "^#" {1}/README.md --no-heading | head -n 1;bat --style "grid,numbers,snip" --color=always --paging never {1}/README.md'
+
+	)
+	_ku_edit "$(echo "${item}" | awk '{print $1}')"
 }

 _ku_update_tags() {
@@ -415,7 +410,7 @@ pwd)
 	fi
 	pwd
 	;;
-fzf) zets "$@" ;;
+fzf) _ku_fzf "$@" ;;
 *)
 	NODE=$CMD
 	SUB_CMD="$(echo "$@" | awk '{print $1}')"
```

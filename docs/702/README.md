# Bash trick to run things in parallel

An attempt to speed up a creating an index for [baking](../292)

```bash
function baking() {
	[ -f "${BAKING_INDEX}" ] && rm "${BAKING_INDEX}"

	baking_process_id() {
		local id="$1"
		local meta_file="${id}/meta.yaml"
		if [ ! -f "${meta_file}" ]; then
			return
		fi

		local baking
		baking=$(yq '.tags[] | select(. == "baking")' "${meta_file}")
		local date
		date=$(yq '.date' "${meta_file}")
		if [ -z "${baking}" ] || [ "${date}" = "null" ]; then
			return
		fi

		local title
		title=$(head -n 1 "${id}/README.md" | sed 's/^# //1')
		echo "- ${date} [${title}](../${id})"
	}

	export -f baking_process_id # Export function for parallel

	local entries=()
	while IFS= read -r line; do
		entries+=("${line}")
	done < <(ku nodes | xargs -P 0 -n 1 -I {} bash -c 'baking_process_id "$@"' _ {})

	# Write sorted entries to file
	printf "%s\n" "${entries[@]}" | sort -r >"${BAKING_INDEX}"
}
```

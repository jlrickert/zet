#!/usr/bin/env bash

set -o errexit  # exit if non-zero status code is returned
set -o nounset  # exit if undefined variable is used
set -o pipefail # exit if no-zero status code is returned in a pipeline

declare NOCOLOR=
[[ -t 1 ]] || NOCOLOR=y
declare GOLD='[38;2;184;138;0m'
declare RED='[38;2;255;0;0m'
declare GREY='[38;2;100;100;100m'
declare CYAN='[38;2;0;255;255m'
declare GREEN='[38;2;0;255;0m'
declare RESET='[0m'

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

BAKING_INDEX="${SCRIPT_DIR}/dex/baking.md"
TAGS_INDEX="${SCRIPT_DIR}/dex/tags"

baking_index() {
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
		echo "${date} [${title}](../${id})"
	}

	export -f baking_process_id # Export function for parallel

	local entries=()
	while IFS= read -r line; do
		entries+=("${line}")
	done < <(ku nodes | xargs -P 0 -n 1 -I {} bash -c 'baking_process_id "$@"' _ {})

	# Write sorted entries to file
	printf "%s\n" "${entries[@]}" | sort -r >"${BAKING_INDEX}"
}

tags_index() {
	[ -f "${TAGS_INDEX}" ] && rm "${TAGS_INDEX}"

	tmp_file=$(mktemp)
	trap 'rm -f "${tmp_file}"' EXIT

	while IFS= read -r id; do
		local meta_file="${id}/meta.yaml"
		if [ ! -f "${meta_file}" ]; then
			continue
		fi
		yq -r '.tags[]' "${meta_file}" | while IFS= read -r tag; do
			echo "${tag} ${id}" >>"${tmp_file}"
		done
	done < <(ku nodes)

	# Write sorted entries to file
	sort -u "${tmp_file}" | awk '
	{
		arr[$1] = arr[$1] ? arr[$1] " " $2 : $2;
	}
	END {
		for (key in arr) {
			print key, arr[key]
		}
	}' >"${TAGS_INDEX}"
	rm "${tmp_file}"
}

time tags_index
echo "${GOLD}Index \"${TAGS_INDEX#"$(pwd)/"}\" updated${RESET}"

time baking_index
echo "${GOLD}Index \"${BAKING_INDEX#"$(pwd)/"}\" updated${RESET}"

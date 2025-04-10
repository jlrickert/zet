#!/usr/bin/env bash

set -o errexit  # exit if non-zero status code is returned
set -o nounset  # exit if undefined variable is used
set -o pipefail # exit if no-zero status code is returned in a pipeline

NOCOLOR=${NOCOLOR:-}
[[ -t 1 ]] || NOCOLOR=y
declare GREEN='[38;2;0;255;0m'
declare RESET='[0m'

if [[ -n "${NOCOLOR}" ]]; then
	GREEN=
	RESET=
fi

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

BAKING_INDEX="${BAKING_INDEX:-"${SCRIPT_DIR}/dex/baking.md"}"
HARDWARES_INDEX="${HARDWARES_INDEX:-"${SCRIPT_DIR}/dex/hardware.md"}"
ISSUES_INDEX="${ISSUES_INDEX:-"${SCRIPT_DIR}/dex/issues.md"}"
OVERVIEW_INDEX="${OVERVIEW_INDEX:-"${SCRIPT_DIR}/dex/overviews.md"}"
PERSONS_INDEX="${PERSONS_INDEX:-"${SCRIPT_DIR}/dex/persons.md"}"
PROJECTS_INDEX="${PROJECTS_INDEX:-"${SCRIPT_DIR}/dex/projects.md"}"
TAGS_INDEX="${TASKS_INDEX:-"${SCRIPT_DIR}/dex/tags"}"
TASKS_INDEX="${TASKS_INDEX:-"${SCRIPT_DIR}/dex/tasks.md"}"

_tags_index() {
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

_hardware_index() {
	[ -f "${HARDWARES_INDEX}" ] && rm "${HARDWARES_INDEX}"
	[ -f "${TAGS_INDEX}" ] || _tags_index

	personal_nodes=$(awk '/^personal / {for (i=2; i<=NF; i++) print $i}' "${TAGS_INDEX}")
	hardware_nodes=$(awk '/^hardware / {for (i=2; i<=NF; i++) print $i}' "${TAGS_INDEX}")

	echo "# Physical haredware that I own " >"${HARDWARES_INDEX}"
	echo "" >>"${HARDWARES_INDEX}"
	for id in ${hardware_nodes}; do
		if grep -qw "${id}" <(echo "${personal_nodes}"); then
			title=$(head -n 1 "${id}/README.md" | sed 's/^# //1')
			echo "- [${title}](../${id})" >>"${HARDWARES_INDEX}"
		fi
	done
}

_baking_index() {
	[ -f "${BAKING_INDEX}" ] && rm "${BAKING_INDEX}"

	awk '/^baking / {for (i=2; i<=NF; i++) print $i}' "${TAGS_INDEX}" | while IFS= read -r id; do
		title=$(head -n 1 "${id}/README.md" | sed 's/^# //1')
		date=$(yq '.date' "${id}/meta.yaml")
		if [ ! "${date}" = "null" ]; then
			echo "- ${date} [${title}](../${id})" >>"${BAKING_INDEX}"
		fi
	done

	sort --reverse --output="${BAKING_INDEX}" "${BAKING_INDEX}"
}

_tasks_index() {
	[ -f "${TASKS_INDEX}" ] && rm "${TASKS_INDEX}"
	[ -f "${TAGS_INDEX}" ] || _tags_index

	awk '/^task / {for (i=2; i<=NF; i++) print $i}' "${TAGS_INDEX}" | while IFS= read -r id; do
		title=$(head -n 1 "${id}/README.md" | sed 's/^# //1')
		echo "- [${title}](../${id})" >>"${TASKS_INDEX}"
	done

}

_person_index() {
	[ -f "${PERSONS_INDEX}" ] && rm "${PERSONS_INDEX}"
	[ -f "${TAGS_INDEX}" ] || tags_index

	awk '/^person / {for (i=2; i<=NF; i++) print $i}' "${TAGS_INDEX}" | while IFS= read -r id; do
		title=$(head -n 1 "${id}/README.md" | sed 's/^# //1')
		echo "- [${title}](../${id})" >>"${PERSONS_INDEX}"
	done
}

_overview_index() {
	[ -f "${OVERVIEW_INDEX}" ] && rm "${OVERVIEW_INDEX}"
	[ -f "${TAGS_INDEX}" ] || tags_index

	awk '/^overview / {for (i=2; i<=NF; i++) print $i}' "${TAGS_INDEX}" | while IFS= read -r id; do
		title=$(head -n 1 "${id}/README.md" | sed 's/^# //1')
		echo "- [${title}](../${id})" >>"${OVERVIEW_INDEX}"
	done
}

_projects_index() {
	[ -f "${PROJECTS_INDEX}" ] && rm "${PROJECTS_INDEX}"
	[ -f "${TAGS_INDEX}" ] || tags_index

	awk '/^project / {for (i=2; i<=NF; i++) print $i}' "${TAGS_INDEX}" | while IFS= read -r id; do
		title=$(head -n 1 "${id}/README.md" | sed 's/^# //1')
		echo "- [${title}](../${id})" >>"${PROJECTS_INDEX}"
	done
}

_issues_index() {
	[ -f "${ISSUES_INDEX}" ] && rm "${ISSUES_INDEX}"
	[ -f "${TAGS_INDEX}" ] || tags_index

	awk '/^issue / {for (i=2; i<=NF; i++) print $i}' "${TAGS_INDEX}" | while IFS= read -r id; do
		title=$(head -n 1 "${id}/README.md" | sed 's/^# //1')
		echo "- [${title}](../${id})" >>"${ISSUES_INDEX}"
	done
}

_tags_index
echo "${GREEN}Index \"${TAGS_INDEX#"$(pwd)/"}\" updated${RESET}"

_baking_index
echo "${GREEN}Index \"${BAKING_INDEX#"$(pwd)/"}\" updated${RESET}"

_person_index
echo "${GREEN}Index \"${PERSONS_INDEX#"$(pwd)/"}\" updated${RESET}"

_overview_index
echo "${GREEN}Index \"${OVERVIEW_INDEX#"$(pwd)/"}\" updated${RESET}"

_tasks_index
echo "${GREEN}Index \"${TASKS_INDEX#"$(pwd)/"}\" updated${RESET}"

_hardware_index
echo "${GREEN}Index \"${HARDWARES_INDEX#"$(pwd)/"}\" updated${RESET}"

_issues_index
echo "${GREEN}Index \"${ISSUES_INDEX#"$(pwd)/"}\" updated${RESET}"

if [ -d "${SCRIPT_DIR}/00_dex" ]; then
    rm -r "${SCRIPT_DIR}/00_dex"
fi
cp -r "${SCRIPT_DIR}/dex" "${SCRIPT_DIR}/00_dex"
# Handling flags in bash

```bash
has_argument() {
	[[ ("$1" == *=* && -n ${1#*=}) || (! -z "$2" && "$2" != -*) ]]
}

extract_argument() {
	echo "${2:-${1#*=}}"
}

while [ $# -gt 0 ]; do
	case $1 in
	-f | --force*)
		if ! has_argument $@; then
			echo "File not specified." >&2
			usage
			exit 1
		fi

		output_file=$(extract_argument $@)

		shift
		;;
	*)
		echo "Invalid option: $1" >&2
		usage
		exit 1
		;;
	esac
	shift
done
```

## See also

- https://medium.com/@wujido20/handling-flags-in-bash-scripts-4b06b4d0ed04#:~:text=Flags%2C%20also%20known%20as%20command,hyphens%20%2D%2D%20for%20long%20options.

## Meta

    tags: #bash

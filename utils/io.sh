#!/usr/bin/bash

check_file_exists(){
	local file=$1

	echo "hello file, $DATA_FILE"

	if [[ ! -f "$file" ]]; then
		echo "X File not found"
		return 1
	fi

		return 0
}

check_command_exists(){
	local cmd="$1"
	local script_path="$COMMAND_DIR/$cmd.sh"

	[[ -f "$script_path" ]] || { 
		echo "Command not found: $cmd"
		cat "$HELP_DIR/general.txt"
		return 1
	}

	return 0
}

show_help_guide(){
	local cmd="$1"
	shift

	for arg in "$@"; do
		[[ "$arg" == "--help" || "$arg" == "-h" ]] && {
			cat "$HELP_DIR/$cmd.txt"
			return 0
		}
	done

	return 1
}

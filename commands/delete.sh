#!/usr/bin/bash

delete_task(){
	source "$UTILS_DIR/io.sh"

	local help_file
	help_file="$HELP_DIR/general.txt"
	[[ -f "$HELP_DIR/delete.txt" ]] && help_file="$HELP_DIR/delete.txt"

	local total_args="$#"
	local task_id="$1"

        if [[ "$task_id" == "-h" || "$task_id" == "--help" ]]; then
		cat "$help_file"
                return 0

        elif (( $total_args != 1 )); then
                cat "$help_file"
                return 1
	fi

	local found=$(jq 'map(select(.id == "'"$task_id"'")) | length' "$DATA_FILE")

	if [[ "$found" == 0 ]];then
		cat "$help_file"
		return 1
	fi

	jq '. | map(select(.id != "'"$task_id"'"))' "$DATA_FILE" > "$DATA_FILE.temp" && mv "$DATA_FILE.temp" "$DATA_FILE"

	echo "Task \"$task_id\" deleted successfully ^o^"
}

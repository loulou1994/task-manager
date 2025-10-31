#!/usr/bin/bash

delete_task() {
	local help_file="$([[ -e "$HELP_DIR/delete.txt" ]] && echo "$HELP_DIR/delete.txt" || echo "$HELP_DIR/general.txt")"

	local total_args="$#"
	local task_id="$1"

	if (($total_args != 1)); then
		cat "$help_file"
		return 1
	fi

	local found=$(jq 'map(select(.id == "'"$task_id"'")) | length' "$DATA_FILE")

	if [[ "$found" == 0 ]]; then
		cat "$help_file"
		return 1
	fi

	jq '. | map(select(.id != "'"$task_id"'"))' "$DATA_FILE" >"$DATA_FILE.temp" && mv "$DATA_FILE.temp" "$DATA_FILE"

	echo "Task \"$task_id\" deleted successfully ^o^"
}

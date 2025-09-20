#!/usr/bin/bash

mark_task(){
	local help_file="$HELP_DIR/general.txt"
	local status="$1"
	local task_id="$2"
	local total_args="$#"

	[[ -f "$HELP_DIR/mark.txt" ]] && help_file="$HELP_DIR/mark.txt"

	[[ "$#" -ne 2 ]] && cat "$help_file" && return 1

	# check for invalid status inputs
	case "$status" in
		"todo"|"in-progress"|"done")
		;;
		*)
		  cat "$help_file"
		  return 1
	esac

	# check if task exists
	local found=$(jq --arg id "$task_id" 'map(select(.id == $id)) | length' "$DATA_FILE")

	echo "$found"
	if [[ "$found" -eq 0 ]]; then
		cat "$help_file"
		return 1
	fi

	jq --arg id "$task_id" --arg status "$status" 'map(if .id == $id then .status = $status else . end)' "$DATA_FILE" > "$DATA_FILE.tmp" && mv "$DATA_FILE.tmp" "$DATA_FILE"
	return 0
}

#!/usr/bin/bash

mark_task(){
	local help_file="$HELP_DIR/mark.txt"
	local status="$1"
	local task_id="$2"
	local total_args="$#"

	[[ "$#" -ne 2 ]] && cat "$help_file" && return 1

	# check for invalid status inputs
	case "$status" in
		"todo"|"in-progress"|"done")
		;;
		*)
		  cat "$help_file"
		  return 1
	esac

	local found_task=$(jq --arg id "$task_id" '.[] | select(.id == $id)' "$DATA_FILE")
	local unchanged_task=$(echo "$found_task" | jq --arg status "$status" \
			'select(.status == $status)' \
			)

	if [[ -z "$found_task" ]]; then
		echo "No such task with id $task_id"
		return 1

	elif [[ -n "$unchanged_task" ]]; then
		echo "Task is already set to the requestd status"
		return 1
	fi

	jq --arg id "$task_id" --arg status "$status" 'map(if .id == $id then .status = $status else . end)' "$DATA_FILE" > "$DATA_FILE.tmp" && mv "$DATA_FILE.tmp" "$DATA_FILE"

	echo "Task '$task_id' updated successfully ^o^"
	return 0
}

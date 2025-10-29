#!/usr/bin/bash

update_task(){
	local help_dir="$HELP_DIR/update.txt" 
	local total_args="$#"
	local task_id="$1"
	local new_description="$2"

	# validate args
	if [[ "$total_args" != 2 ]]; then
		cat "$help_dir"
		return 1
	fi

        # check if task exists
        local found

        found=$(jq --arg id "$task_id" 'map(select(.id == $id)) | length' "$DATA_FILE")

        if [[ "$found" == 0 ]]; then
                echo "X no task found with ID: $task_id"
                return 1
        fi

	# update the title
        jq --arg id "$task_id" --arg description "$new_description" '
                map(if .id == $id then .description = $description else . end)
		' "$DATA_FILE" > "$DATA_FILE.tmp" && mv "$DATA_FILE.tmp" "$DATA_FILE"

        echo "Task ID $task_id updated to: \"$new_description\" ( ͡° ͜ʖ ͡°)"
}

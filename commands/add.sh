#!/usr/bin/bash

add_task() {
  local help_dir="$HELP_DIR/add.txt"

  local total_args="$#"
  local description="$1"

  if [[ -z "$description" || "$total_args" -gt 1 ]]; then
	cat $help_dir
	return 1
  elif [[ "$description" == "--help" || "$description" == "-h" ]]; then
	cat $help_dir
	return 0
  fi

  # Create data directory and file if they don't exist
  mkdir -p "$(dirname "$DATA_FILE")"
  [[ ! -f "$DATA_FILE" ]] && echo '[]' > "$DATA_FILE"

  # generate unique ID and timestamp
  local id
  id=$(date +%s%N) # nanosecond timestamp as unique ID

  local timestamp
  timestamp=$(date +"%Y-%m-%d %H:%M:%S")

  # create new task object
  local new_task
  new_task=$(jq -n \
	--arg id "$id" \
	--arg description "$description" \
	--arg status "todo" \
	--arg created_at "$timestamp" \
	--arg updated_at "$timestamp" \
	'{id: $id, description: $description, status: $status, created_at: $created_at, updated_at: $updated_at}'
  )

  # append task to JSON file
  jq ". += [$new_task]" "$DATA_FILE" > "$DATA_FILE.tmp" && mv "$DATA_FILE.tmp" "$DATA_FILE"

  echo "Task added successfully (ID: "$id") ^o^"
}

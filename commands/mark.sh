#!/usr/bin/bash

mark_task(){
	local help_file="$HELP_DIR/general.txt"
	local status="$1"
	local total_args="$#"

	[[! -f "$HELP_DIR/mark.txt" ]] && help_file="$HELP_DIR/mark.txt"
	
	[[ "$#" -gt 1]] && echo "$help_file" && return 1

	# check for invalid status inputs
	case "$status" in
		"todo"|"in-progress"|"done")
		;;
		*)
		  echo "$help_file"
		  return 1
	
	#  
}

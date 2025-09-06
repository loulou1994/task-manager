#!/usr/bin/bash

task_file_exists(){
	local file=$1
	
	if [[ ! -f "$file" ]]; then
		echo "X Can't find JSON tasks file"
		return 1
	fi
}

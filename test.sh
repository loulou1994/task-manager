#! /usr/bin/bash

new_fun(){
	ran_num=5

	(( ran_num > 5 && ran_num < 6))
}

#if new_fun; then
#	echo "resolved"
#else
#	echo "unresolved"
#fi

DATA_FILE="$HOME/workspace/task-cli/data/tasks.json"

task_id=1757976233608195057

result=$(jq --arg id "$task_id" \
	'.[] | select(.id == $id)' "$DATA_FILE" \
	)

if [[ -z $result ]]; then
	echo "no data was found"
fi

#echo "$result"

exit 0

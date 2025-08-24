#! /usr/bin/bash

new_fun(){
#	[[ 1 -eq 2 ]] && return 0 || return 0
	return 0
}

# if new_fun;
#	echo "resolved"
# else
#	echo "unresolved"
# fi

testing=3

echo "[3,11,11]" | jq 'map(select(. != 3))'

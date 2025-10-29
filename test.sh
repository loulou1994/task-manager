#! /usr/bin/bash

new_func_task(){
	first_var="$1"

	echo "$first_var"
}

source "./utils/io.sh"

COMMAND="$1"
#shift

#case "$COMMAND" in
#	new_func|FO|FA)
#		echo "it'a new_func or FO or FA"
#		"${COMMAND}_task" "$@"
#		;;
#	FO)
#		echo "another FO thing"
#		;;
#	*)
#		echo "invalide data".
#		exit 1
#		;;
#esac

char_count="$(echo wc -m COMMAND)"

echo "$char_count"
exit 0

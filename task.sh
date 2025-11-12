#!/usr/bin/bash

PROJECT_DIR="$(dirname $(readlink -f "$0"))"

# Load Configurations & helpers
source "$PROJECT_DIR/config.sh"
source "$UTILS_DIR/io.sh"

# Dispatch commands
COMMAND=$1

# check_command_exists "$COMMAD" || exit 1
show_help_guide "$@" && exit 0

shift # remove the command so the $@ holds the remaining arguments

case "$COMMAND" in
add)
	source "$COMMAND_DIR/add.sh"
	add_task "$@"
	;;
mark | update | delete | list)
	source "$COMMAND_DIR/$COMMAND.sh"

	if check_file_exists "$DATA_FILE"; then
		"${COMMAND}_task" "$@"
	else
		echo "You must create the json file $DATA_FILE before making any changes"
	fi
	
	;;
# list)
# 	source "$COMMAND_DIR/list.sh"
# 	list_tasks "$@"
# 	;;
# update)
# 	source "$COMMAND_DIR/update.sh"
# 	update_task "$@"
# 	;;
# delete)
# 	source "$COMMAND_DIR/delete.sh"
# 	delete_task "$@"
# 	;;
# mark)
# 	source "$COMMAND_DIR/mark.sh"
# 	mark_task "$@"
# 	;;
help | "")
	if [[ -n "$1" ]]; then
		help_file="$HELP_DIR/$1.txt"
		[[ -f "$help_file" ]] && cat "$help_file" || echo "No help found for '$1'"
	else
		cat "$HELP_DIR/general.txt"
	fi
	;;
*)
	echo "Command not found: $COMMAND"
	cat "$HELP_DIR/general.txt"
	exit 1
	;;
esac

exit 0
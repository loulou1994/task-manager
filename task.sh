#!/usr/bin/bash

SCRIPT_PATH="$(readlink -f "$0")"
PROJECT_DIR="$(dirname "$SCRIPT_PATH")"

# Load Configurations
source "$PROJECT_DIR/config.sh"

# Dispatch commands
COMMAND=$1
shift # remove the command so the $@ holds the remaining arguments

case "$COMMAND" in
	add)
	  source "$COMMAND_DIR/add.sh"
	  add_task "$@"
	  ;;
	list)
	  source "$COMMAND_DIR/list.sh"
	  list_tasks "$@"
	  ;;
	update)
	  source "$COMMAND_DIR/update.sh"
	  update_task "$@"
	  ;;
	delete)
	  source "$COMMAND_DIR/delete.sh"
	  delete_task "$@"
	  ;;
	help|"")
	  if [[ -n "$1" ]]; then
		HELP_FILE="$HELP_DIR/$1.txt"
		[[ -f "$HELP_FILE" ]] && cat "$HELP_FILE" || echo "No help found for '$1'"
	  else
		cat "$HELP_DIR/general.txt"
	  fi
	  ;;
	*)
		echo "X unknown command: $COMMAND"
		cat "$HELP_DIR/general.txt"
		exit 1
		;;
	esac

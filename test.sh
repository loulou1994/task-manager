#! /usr/bin/bash

new_fun(){
	ran_num=5

	(( ran_num > 5 && ran_num < 6))
}

if new_fun; then
	echo "resolved"
else
	echo "unresolved"
fi

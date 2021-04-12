#!/bin/sh

sql_is_running()
{
	if ps -e | grep -q $1 ; then
		return 1
	else
		return 0
	fi
}

# $@ holds list of all arguments passed to the script.
# $1 is the first argument

while true; do
i=1
sleep 3
	for arg in "$@" 
		do 
		if sql_is_running $arg -eq 0 ;then
			printf "$arg isn't running\nExit...\n"
			exit 1
		fi
		i=`expr $i + 1` 
	done
done
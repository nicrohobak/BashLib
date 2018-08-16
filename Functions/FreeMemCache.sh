#!/bin/bash

#
# FreeMemCache
#


# Function:	FreeMemCache -- Checks to see if the current shell (probably) has sudo access
# Params:	$1 - Any value passed in will suppress output
# Output:	Prints pre/post RAM info and function progress info
function FreeMemCache
{
	local SUPPRESS_OUTPUT=$( if [ "${1}" != "" ]; then echo "true"; else echo "false"; fi )

	if [ "${SUPPRESS_OUTPUT}" != "true" ]; then
		Print "Previous RAM usage:"
		free -h
		Print ""
		Print -n "Putting in a request with the kernel to drop the current memory cache..."
	fi

	local PROC_DROP_CACHES="/proc/sys/vm/drop_caches"
	sudo sh -c "echo 3 > '${PROC_DROP_CACHES}'"

	if [ "${?}" != "0" ]; then
		Error "FreeMemCache: Failed to write to '${PROC_DROP_CACHES}'."
		return 1
	fi

	if [ "${SUPPRESS_OUTPUT}" != "true" ]; then
		Print "Done."

		Print -n "Freeing used swap space..."
	fi

	sudo swapoff -a && sudo swapon -a

	if [ "${?}" != "0" ]; then
		Error "FreeMemCache: Failed to free swap space."
		return 1
	fi

	if [ "${SUPPRESS_OUTPUT}" != "true" ]; then
		Print "Done."
		Print ""
		Print "Current RAM usage:"
		free -h
	fi

	return 0
}


# vim: tabstop=4 shiftwidth=4



#!/bin/bash

#
# EatWhite
#


# Function:	EatWhite -- Removes all leading/trailing whitespace characters
# Params:	$* - The string
# Output:	String (a whitespace-trimmed version of the input)
function EatWhite
{
	if [ "$1" = "" ]; then
		Error "EatWhite: No input provided."
		return 1
	fi

	echo "$*" | sed 's/^\s*//' | sed 's/\s*^//'
	return 0
}


# vim: tabstop=4 shiftwidth=4



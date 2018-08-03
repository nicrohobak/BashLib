#!/bin/bash

#
# StrToLower
#


# Function:	StrToLower -- Converts a string to lowercase
# Params:	$* - The string
# Output:	String (a lowercase version of the input)
function StrToLower
{
	if [ "${1}" = "" ]; then
		Error "StrToLower: No input provided."
		return 1
	fi

	echo $* | tr '[:upper:]' '[:lower:]'
	return 0
}


# vim: tabstop=4 shiftwidth=4



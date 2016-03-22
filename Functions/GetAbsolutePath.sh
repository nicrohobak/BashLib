#!/bin/bash

#
# GetAbsolutePath
#


# Function:	GetAbsolutePath
# Params:	$1 - Relative file name
# Output:	String (the absolute path of the input parameter), or Error Message
function GetAbsolutePath
{
	if [ "$1" == "" ]; then
		Error "No file name given."
		return 1
	elif [ ! -e "$1" ]; then
		Error "File doesn't exist. ($1)"
		return 1
	fi

	cd `dirname $1` && echo "`pwd`/`basename $1`" && cd - &> /dev/null
	return 0
}


# vim: tabstop=4 shiftwidth=4



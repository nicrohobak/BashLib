#!/bin/bash

#
# SetIFS
# Helps to set the Bash 'Internal Field Separator' a little easier
#


# Function:	SetIFS
# Params:	$1 - New IFS string (accepts backslash escape sequences, like '\n')
# Output:	(None)
function SetIFS
{
	IFS=$( printf "$1" )
	return 0
}


# vim: tabstop=4 shiftwidth=4



#!/bin/bash

#
# HasSudoAccess
#


# Function:	HasSudoAccess -- Checks to see if the current shell (probably) has sudo access
# Params:	(None)
# Output:	Return code 0 = (Probably) Has Sudo Access
function HasSudoAccess
{
	if [ "$(whoami)" = "root" ] || [ "$(id | grep -e "sudo" -e "wheel")" != "" ]; then
		return 0
	fi

	return 1
}


# vim: tabstop=4 shiftwidth=4



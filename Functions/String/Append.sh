#!/bin/bash

#
# Append
# Appends new content to a variable
#


# Function:	Append
# Params:	$1 - Destination Variable
#           $* - Remaining params added to variable
# Output:	(None)
function Append
{
	if [ "${1}" = "" ]; then
		Error "Append usage: <DEST> <NEW_CONTENT> [<NEW_CONTENT> ...]"
		return 1
	fi

	local DEST="${1}"

	shift   # Shift to pop the variable name off of the parameter list

	#
	# WARNING: There's always an inherent security risk when `eval` is used!
	#          This is handy, but use with extreme caution!
	#
	if [ "${!DEST}" = "" ]; then
		eval "${DEST}=\"$*\""
	else
		eval "${DEST}=\"\$${DEST} $*\""
	fi

	return 0
}


# vim: tabstop=4 shiftwidth=4



#!/bin/bash

#
# IsNumber
#


# Function:	IsNumber -- Determines if a string is numerical
# Params:	$* - The string
# Output:	(None, returns '0' if numeric)
function IsNumber
{
	if [ "${*}" = "" ]; then
		Error "IsNumber: No input provided."
		return 1
	fi

	case ${*} in
		''|*[!0-9]*)	return 1	;;
	esac

	return 0
}


# vim: tabstop=4 shiftwidth=4



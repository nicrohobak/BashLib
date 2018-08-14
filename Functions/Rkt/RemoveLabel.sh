#!/bin/bash

#
# RktRemoveLabel
#


# Function: RktRemoveLabel
# Params:   $1 - Label
# Output:   (Normal acbuild output)
function RktRemoveLabel
{
	if [ "${1}" = "" ]; then
		Error "Rkt_RemoveLabel: No label provided."
		return 1
	fi

	local LABEL="${1}"

	${ACBUILD} label remove "${LABEL}"

	if [ "${?}" != "0" ]; then
		Error "Rkt_RemoveLabel: Failed to remove the label '${LABEL}'."
		return 1
	fi

	return 0
}


# vim: tabstop=4 shiftwidth=4



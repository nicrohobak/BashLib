#!/bin/bash

#
# RktSetLabel
#


# Function: RktSetLabel
# Params:   $1 - Label
#           $2 - Value
# Output:   (Normal acbuild output)
function RktSetLabel
{
	if [ "${1}" = "" ]; then
		Error "Rtk_SetLabel: Missing label."
		return 1
	fi

	if [ "${2}" = "" ]; then
		Warn "Rkt_SetLabel: Missing value.  (Maybe Rkt_RemoveLabel is more appropriate?)"
	fi

	local LABEL="${1}"
	local VALUE="${2}"

	${ACBUILD} label add "${LABEL}" "${VALUE}"

	if [ "${?}" != "0" ];then
		Error "Rkt_SetLabel: Failed to set the label '${LABEL}' to '${VALUE}'."
		return 1
	fi

	return 0
}


# vim: tabstop=4 shiftwidth=4



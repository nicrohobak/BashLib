#!/bin/bash

#
# RktWriteImage
#


# Function: RktWriteImage
# Params:   $1 - Image path
#			$2 - (Any value triggers an auto-cleanup)
# Output:   
function RktWriteImage
{
	if [ "${1}" = "" ]; then
		Error "Rkt_WriteImage: No output path provided."
		return 1
	fi

	local IMAGE="${1}"

	sudo ${ACBUILD} write --overwrite "${IMAGE}"

	if [ "${?}" != "0" ]; then
		Error "Rkt_WriteImage: Failed to write '${IMAGE}'."
		return 1
	fi

	if [ "${2}" != "" ]; then
		Rkt_EndImage
	fi

	return 0
}


# vim: tabstop=4 shiftwidth=4



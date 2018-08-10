#!/bin/bash

#
# RktFindRunningImage
#


# Function: RktFindRunningImage
# Params:   ${1}
# Output:   If found, the shorthand UUID for the running pod
function RktFindRunningImage
{
	if [ "${1}" = "" ]; then
		Error "RktFindRunningImage: No image name provided."
		return 1
	fi

	local IMAGE_NAME="${1}"
	local KEYWORD="running"
	local FOUND_ID=$( ${RKT} list | grep -B 1 "$(${RKT} list | grep -A 1 "${KEYWORD}" | grep "\-${IMAGE_NAME}" | awk '{ print $1; }')" | grep "${KEYWORD}" | awk '{ print $1; }' )

	if [ "${FOUND_ID}" = "" ]; then
		Error "RktFindRunningImage: Image not found.  (${IMAGE_NAME})"
		return 1
	fi

	Print "${FOUND_ID}"
	return 0
}


# vim: tabstop=4 shiftwidth=4



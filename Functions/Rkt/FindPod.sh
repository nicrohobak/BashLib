#!/bin/bash

#
# RktFindPod
#


# Function: RktFindPod
# Params:   ${1} - Image keyword
#			${2} - Image state (prepared/running/exited/any/etc.  If none is provided, 'any' is implied.)
# Output:   If found, the shorthand UUID for the prepared pod
function RktFindPod
{
	if [ "${1}" = "" ]; then
		Error "RktFindPod: No image name provided."
		return 1
	fi

	local IMAGE="${1}"
	local STATE="${2}"
	local FOUND_ID=$( ${RKT} list | grep -B 1 "$(${RKT} list | grep -A 1 "${STATE}" | grep "${IMAGE}" | awk '{ print $1; }')" | grep "${STATE}" | awk '{ print $1; }' )

	if [ "${FOUND_ID}" = "" ]; then
		Error "RktFindPod: Image not found.  (${IMAGE_NAME})"
		return 1
	fi

	Print "${FOUND_ID}"
	return 0
}


# vim: tabstop=4 shiftwidth=4



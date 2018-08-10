#!/bin/bash

#
# RktFindPreparedImage
#


# Function: RktFindPreparedImage
# Params:   ${1}
# Output:   If found, the shorthand UUID for the prepared pod
function RktFindPreparedImage
{
	if [ "${1}" = "" ]; then
		Error "RktFindPreparedImage: No image name provided."
		return 1
	fi

	local IMAGE_NAME="${1}"
	local KEYWORD="prepared"
	local FOUND_ID=$( ${RKT} list | grep -B 1 "$(${RKT} list | grep -A 1 "${KEYWORD}" | grep "\-${IMAGE_NAME}" | awk '{ print $1; }')" | grep "${KEYWORD}" | awk '{ print $1; }' )

	if [ "${FOUND_ID}" = "" ]; then
		Error "RktFindPreparedImage: Image not found.  (${IMAGE_NAME})"
		return 1
	fi

	Print "${FOUND_ID}"
	return 0
}


# vim: tabstop=4 shiftwidth=4



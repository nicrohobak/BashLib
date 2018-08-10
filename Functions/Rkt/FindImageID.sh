#!/bin/bash

#
# RktFindImageID
#


# Function: RktFindImageID
# Params:   ${1}
# Output:   If found, the sha512 short ID for the image
function RktFindImageID
{
	if [ "${1}" = "" ]; then
		Error "FindRktImageID: No image name provided."
		return 1
	fi

	local IMAGE_NAME="${1}"
	local FOUND_ID=$( ${RKT} image list | grep "${IMAGE_NAME}" | awk '{ print $1; }' )

	if [ "${FOUND_ID}" = "" ]; then
		Error "FindRktImageID: Image not found.  (${IMAGE_NAME})"
		return 1
	fi

	Print "${FOUND_ID}"
	return 0
}


# vim: tabstop=4 shiftwidth=4



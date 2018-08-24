#!/bin/bash

#
# RktFindImage
#


# Function: RktFindImage
# Params:   ${1}
# Output:   If found, the sha512 short ID for the image
function RktFindImage
{
	if [ "${1}" = "" ]; then
		Error "RktFindImage: No image name provided."
		return 1
	fi

	local IMAGE_NAME="${1}"
	local FOUND_ID=$( ${RKT} image list | grep "${IMAGE_NAME}" | awk '{ print $1; }' )

	if [ "${FOUND_ID}" = "" ]; then
		Error "RktFindImage: Image not found.  (${IMAGE_NAME})"
		return 1
	fi

	Print "${FOUND_ID}"
	return 0
}


# vim: tabstop=4 shiftwidth=4



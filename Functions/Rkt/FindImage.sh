#!/bin/bash

#
# RktFindImage
#


# Function: RktFindImage
# Params:   ${1}
# Output:   If found, the sha512 short ID for the image
function RktFindImage
{
	local IMAGE="${1}"

	if [ "${IMAGE}" = "" ]; then
		Error "RktFindImage: No image name provided."
		return 1
	fi

	local HEADER="IMPORT TIME"
	local FOUND_ID=$( ${RKT} image list | grep -v "${HEADER}" | grep -e "${IMAGE}" | awk '{ print $1; }' )

	if [ "${FOUND_ID}" = "" ]; then
		Error "RktFindImage: Image not found.  (${IMAGE})"
		return 1
	fi

	Print "${FOUND_ID}"
	return 0
}


# vim: tabstop=4 shiftwidth=4



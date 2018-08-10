#!/bin/bash

#
# RktFindImage
#


# Function: RktFindImage
# Params:   ${1}
# Output:   If found, the full sha512 hash as exists on disk
function RktFindImage
{
	if [ "${1}" = "" ]; then
		Error "RktFindImage: No image name provided."
		return 1
	fi

	local IMAGE_NAME="${1}"
	local FOUND_ID=$( RktFindImageID "${IMAGE_NAME}" 2>&1 )

	if [ "$(echo "${FOUND_ID}" | grep "Image not found.")" != "" ]; then
		Error "RktFindImage: Image not found.  (${IMAGE_NAME})"
		return 1
	fi

	local RKT_IMAGE_PATH="${RKT_DATA_DIR}/cas/blob/sha512"
	local SHA512_PREFIX="${FOUND_ID:7:2}"

	Print "$( ls -w 1 ${RKT_IMAGE_PATH}/${SHA512_PREFIX}/${FOUND_ID}* | awk '{ print $1; }' )"
	return 0
}


# vim: tabstop=4 shiftwidth=4



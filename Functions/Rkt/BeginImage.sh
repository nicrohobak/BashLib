#!/bin/bash

#
# RktBeginImage
#


# Function: RktBeginImage
# Params:   $1 - Base image
# Output:   
function RktBeginImage
{
	# Clean up any previous runs
	if [ -d "${RKT_ACBUILD_TMP}" ]; then
		Print "Rkt_BeginImage: Clearing out the previous image build data.  (rm -rf '${RKT_ACBUILD_TMP}')"
		sudo rm -rf "${RKT_ACBUILD_TMP}"

		if [ "${?}" != "0" ]; then
			Error "Failed to clean out the previous image data."
			return 1
		fi
	fi

	local BASE_CONTAINER_IMAGE="${1}"
	local IMAGE_ID=""
	if [ "${BASE_CONTAINER_IMAGE}" != "" ]; then
		# Find the image in the local store
		IMAGE_ID=$( RktFindImage "${BASE_CONTAINER_IMAGE}" )

		if [ "${IMAGE_ID}" = "" ] || [ "$(echo "${IMAGE_ID}" | grep "Image not found.")" != "" ]; then
			Error "Rkt_BeginImage: Failed to find the base image '${BASE_CONTAINER_IMAGE}'.  (Did you fetch it yet?)"
			return 1
		fi
	fi

	# Start the image
	${ACBUILD} begin "${IMAGE_ID}" --insecure	|| Fatal "'acbuild begin' failed.  (Image ID: ${IMAGE_ID})"

	# Set our working directory at the container root
	${ACBUILD} set-working-directory			|| Fatal "Failed to set the container's working directory."

	return 0
}


# vim: tabstop=4 shiftwidth=4



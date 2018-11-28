#!/bin/bash

#
# RktUpdateImages
#


# Default base-images to fetch
RKT_IMAGE_LIST="docker://alpine:latest"


# Function: RktUpdateImages
# Params:   $* - Images to fetch (in addition to the base list)
# Output:   (Progress / Status)
function RktUpdateImages
{
	local IMAGE_LIST="${*} ${RKT_IMAGE_LIST}"

	if [ "${IMAGE_LIST}" = "" ]; then
	    Warn "RktUpdateImages: No images to fetch.  Nothing to do."
	    exit 0
	fi

	local IMAGE
	for IMAGE in ${IMAGE_LIST}; do
		Print "Fetching '${IMAGE}'..."

		# Explictly allow insecure images for wider compatibility
		${RKT} fetch "${IMAGE}"

		if [ "${?}" != "0" ]; then
			Error "RktUpdateImages: Failed to fetch '${IMAGE}'."
			return 1
		fi
	done	

	Print -n "Adjusting local image permissions to allow read access for 'rkt' group..."
	chmod -R g+r "${RKT_IMAGE_PATH}"

	if [ "${?}" != "0" ]; then
		Warn "RktUpdateImages: Failed to set group read permissions on everything within '${RKT_IMAGE_PATH}'.  Attempting again with 'sudo'..."
		sudo chmod -R g+r "${RKT_IMAGE_PATH}"

		if [ "${?}" != "0" ]; then
			Error "RktUpdateImages: Failed to set group read permissoins on '${RKT_IMAGE_PATH}'."
			return 1
		else
			Print "Done."
		fi
	else
		Print "Done."
	fi

	Print "All images fetched successfully."
	return 0
}


# vim: tabstop=4 shiftwidth=4




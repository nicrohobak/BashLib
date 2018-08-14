#!/bin/bash

#
# RktSetEntry
#


# Function: RktSetEntry
# Params:   $1 - Path to entry script on host
#			$2 - Path to entry script on container
# Output:   
function RktSetEntry
{
	local ENTRY_PATH="${RKT_DEFAULT_ENTRY_PATH}"
	local ENTRY_POINT="${RKT_DEFAULT_ENTRY_POINT}"

	if [ "${1}" = "" ] || [ ! -e "${1}" ]; then
		Error "Rkt_SetEntry: Entry script '${1}' not found."
		return 1
	fi

	local SCRIPT="${1}"

	if [ "${2}" != "" ]; then
		ENTRY_PATH="${2}"
		ENTRY_POINT=$( echo "${ENTRY_PATH}" | sed 's/^.*\///' )
		ENTRY_PATH=$( echo "${ENTRY_PATH}" | sed 's/\/[^/]*$//' )

		if [ "${ENTRY_PATH}" = "" ]; then
			ENTRY_PATH="/"
		fi
	fi

	IS_MISSING=$( sudo ${ACBUILD} run -- [ ! -e "${ENTRY_PATH}" ] && echo "true" )

	if [ "${IS_MISSING}" = "true" ]; then
		sudo ${ACBUILD} run mkdir -- -p "${ENTRY_PATH}"

		if [ "${?}" != "0" ]; then
			Error "Rkt_SetEntry: Failed to create '${ENTRY_PATH}' on the image."
			return 1
		fi
	fi

	sudo ${ACBUILD} copy "${SCRIPT}" "${ENTRY_PATH}/${ENTRY_POINT}"

	if [ "${?}" != "0" ]; then
		Error "Rkt_SetEntry: Failed to copy '${SCRIPT}' to '${ENTRY_PATH}/${ENTRY_POINT}'."
		return 1
	fi

	# Make sure it's executable
	#sudo ${ACBUILD} run chmod -- 700 "${ENTRY_PATH}/${ENTRY_POINT}"
	# Manually set the executable bit, since we may not have chmod in this image
	chmod +x "${RKT_ACBUILD_ROOTFS}/${ENTRY_PATH}/${ENTRY_POINT}"

	if [ "${?}" != "0" ]; then
		Error "Rkt_SetEntry: Failed to make '${ENTRY_PATH}/${ENTRY_POINT}' executable."
		return 1
	fi

	# And then set it as our official entry point
	sudo ${ACBUILD} set-exec -- "${ENTRY_PATH}/${ENTRY_POINT}"

	if [ "${?}" != "0" ]; then
		Error "Rkt_SetEntry: Failed to set '${ENTRY_PATH}/${ENTRY_POINT}' as the container entry point."
		return 1
	fi

	return 0
}


# vim: tabstop=4 shiftwidth=4



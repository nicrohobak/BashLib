#!/bin/bash

#
# RktCopyHosts
#


# Function: RktCopyHosts
# Params:   $1 - Host's '/etc/hosts' location
#           $2 - Container's '/etc/hosts' location
# Output:   (Normal acbuild output)
function RktCopyHosts
{
	local HOSTS="/etc/hosts"
	local RKT_HOSTS="/etc/hosts"

	if [ "${1}" != "" ]; then
		HOSTS="${1}"
	fi

	if [ "${2}" != "" ]; then
		RKT_HOSTS="${2}"
	fi

	sudo ${ACBUILD} copy "${HOSTS}" "${RKT_HOSTS}"

	if [ "${?}" != "0" ]; then
		Error "Rkt_CopyHosts: Failed to copy '${HOSTS}' to 'rkt:${RKT_HOSTS}'."
		return 1
	fi

	return 0
}


# vim: tabstop=4 shiftwidth=4



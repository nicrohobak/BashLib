#!/bin/bash

#
# RktCopyDNS
#


# Function: RktCopyDNS
# Params:   $1 - Host's '/etc/resolv.conf' location
#           $2 - Container's '/etc/resolv.conf' location
# Output:   (Normal acbuild output)
function RktCopyDNS
{
	local RESOLV_CONF="/etc/resolv.conf"
	local RKT_RESOLV_CONF="/etc/resolv.conf"

	if [ "${1}" != "" ]; then
		RESOLV_CONF="${1}"
	fi

	if [ "${2}" != "" ]; then
		RKT_RESOLV_CONF="${2}"
	fi

	sudo ${ACBUILD} copy "${RESOLV_CONF}" "${RKT_RESOLV_CONF}"

	if [ "${?}" != "0" ]; then
		Error "Rkt_CopyDNS: Failed to copy '${RESOLV_CONF}' to 'rkt:${RKT_RESOLV_CONF}'."
		return 1
	fi

	return 0
}


# vim: tabstop=4 shiftwidth=4



#!/bin/bash

#
# RktCheckForPkgMgr
#


# Function: RktCheckForPkgMgr
# Params:   $1 - Package manager (binary name)
# Output:   (None, returns '0' if found)
function RktCheckForPkgMgr
{
	if [ "${1}" = "" ]; then
		Error "Rkt_CheckForPkgMgr: No package manager provided."
		return 1
	fi

	local CHECK_MGR="${1}"

	local MGR
	for MGR in ${RKT_PKGMGR_LIST}; do
		if [ "${MGR}" = "${CHECK_MGR}" ]; then
			return 0
		fi
	done

	Error "Rkt_CheckForPkgMgr: Package manager '${CHECK_MGR}' not found."
	return 1
}


# vim: tabstop=4 shiftwidth=4



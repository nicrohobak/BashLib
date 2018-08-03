#!/bin/bash

#
# FindPackageManagers
#


# Function:	FindPackageManagers - Attempts to locate the package manager
# Params:	(None)
# Output:	(None)
function FindPackageManagers
{
	local SUPPORTED_PKG_MGRS="aptitude apt-get yum"
	local PKG_MGR=""
	local FIND_PKG_MGR=""

	for FIND_PKG_MGR in ${SUPPORTED_PKG_MGRS}; do
		PKG_MGR=$(which ${FIND_PKG_MGR})

		if [ "${PKG_MGR}" != "" ]; then
			Print "${PKG_MGR}"
			return 0
		fi
	done

	Error "FindPackageManager: Failed to find any supported package managers. (${SUPPORTED_PKG_MGRS})"
	return 1
}


# vim: tabstop=4 shiftwidth=4



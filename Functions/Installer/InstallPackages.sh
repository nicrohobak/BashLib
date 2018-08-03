#!/bin/bash

#
# InstallPackages
#


# Function:	InstallPackages - Attempts to install the named packages
# Params:	$* - List of packages to pass to the package manager
# Output:	(None)
# !!!!!!:   Requires 'sudo'
function InstallPackages
{
	if [ "$1" == "" ]; then
		Error "InstallPackages: No packages provided."
		return 1
	fi

	# Find the package manager first
	local PKG_MGR="$( FindPackageManager )"

	if [ "${PKG_MGR}" = "" ] || [ "$(echo "${PKG_MGR}" | grep "Failed to find")" != "" ]; then
		Error "InstallPackage: ${PKG_MGR}"
		return 1
	fi

	# Then update it
	sudo "${PKG_MGR}" update

	if [ "${?}" != "0" ]; then
		Error "InstallPackage: Failed to update the package manager. (${PKG_MGR})"
		return 1
	fi

	# And finally install
	sudo "${PKG_MGR}" -y install $*

	return "${?}"
}


# vim: tabstop=4 shiftwidth=4



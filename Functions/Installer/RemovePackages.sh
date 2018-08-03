#!/bin/bash

#
# RemovePackages
#


# Function:	RemovePackages - Attempts to remove the named packages
# Params:	$* - List of packages to pass to the package manager
# Output:	(None)
# !!!!!!:   Requires 'sudo'
function RemovePackages
{
    if [ "$1" == "" ]; then
		Error "RemovePackages: No packages provided."
		return 1
    fi

    # Find the package manager first
    local PKG_MGR="$( FindPackageManager )"

    if [ "$(echo "${PKG_MGR}" | grep "Failed to find")" != "" ]; then
        Error "RemovePackage: ${PKG_MGR}"
        return 1
    fi
    
    # And remove
    sudo "${PKG_MGR}" -y remove $*

    return "${?}"
}


# vim: tabstop=4 shiftwidth=4



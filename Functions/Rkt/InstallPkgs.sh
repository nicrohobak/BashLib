#!/bin/bash

#
# RktInstallPkgs
#


# Function: RktInstallPkgs
# Params:   $1 - Package manager (optional)
#			$@ - Packages to install
# Output:   (Normal acbuild output)
function RktInstallPkgs
{
	if [ "${1}" = "" ]; then
		Error "Rkt_InstallPkgs: No packages provided."
		return 1
	fi

	local PKG_MGR="${1}"

	Rkt_CheckForPkgMgr "${PKG_MGR}" &> /dev/null

	# If the first parameter doesn't pan out as a package manager, go with the default
	if [ "${?}" != "0" ]; then
		PKG_MGR="${RKT_PKGMGR_DEFAULT}"
	fi

	# Find the proper commands to use with our package manager
	local UPDATE="${RKT_PKGMGR_UPDATE["${PKG_MGR}"]}"
	if [ "${UPDATE}" = "" ]; then
		UPDATE="${RKT_PKGMGR_UPDATE["default"]}"
	fi

	local INSTALL="${RKT_PKGMGR_INSTALL["${PKG_MGR}"]}"
	if [ "${INSTALL}" = "" ]; then
		INSTALL="${RKT_PKGMGR_INSTALL["default"]}"
	fi

	if [ "${UPDATE}" = "" ] || [ "${INSTALL}" = "" ]; then
		Error "Rkt_InstallPkgs: Failed to find a suitable package manager."
		return 1
	fi

	sudo ${ACBUILD} run -- ${PKG_MGR} ${UPDATE}

	if [ "${?}" != "0" ]; then
		Error "Rkt_InstallPkgs: Failed to update the package manager. (${PKG_MGR} ${UPDATE})"
		return 1
	fi

	sudo ${ACBUILD} run -- ${PKG_MGR} ${INSTALL} ${@}
	
	if [ "${?}" != "0" ]; then
		Error "Rkt_InstallPkgs: Failed to install the packages with the package manager. (${PKG_MGR} ${INSTALL} ${@})"
		return 1
	fi

	local CLEAN="${RKT_PKGMGR_CLEAN["${PKG_MGR}"]}"
	if [ "${CLEAN}" != "" ]; then
		sudo ${ACBUILD} run -- ${PKG_MGR} ${CLEAN}
	fi

	if [ "${?}" != "0" ]; then
		Error "Rkt_InstallPkgs: Failed to install: ${@}"
		return 1
	fi

	return 0
}


# vim: tabstop=4 shiftwidth=4



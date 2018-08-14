#!/bin/bash

#
# RktLaunchShell
#


# Function: RktLaunchShell
# Params:   $1 - Desired shell
# Output:   (Starts an interactive session)
function RktLaunchShell
{
	local SHELL="/bin/sh"

	if [ "${1}" != "" ]; then
		SHELL="${1}"
	fi

	sudo ${ACBUILD} run -- "${SHELL}"

	if [ "${?}" != "0" ]; then
		Error "Rkt_LaunchShell: Failed to launch '${SHELL}'."
		return 1
	fi

	return 0
}


# vim: tabstop=4 shiftwidth=4



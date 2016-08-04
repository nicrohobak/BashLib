#!/bin/bash

#
# Glob
# Enables/disables "globbing" (normally on)
#


# Function:	Glob
# Params:	$1 - (on|off) - If no parameter is provided, "on" is assumed
# Output:	(None)
function Glob
{
	case "$1" in
		off|Off|oFf|ofF|OFf|oFF|OfF|OFF)
			set -f
			;;
		*)
			set +f
			;;
	esac

	return 0
}


# vim: tabstop=4 shiftwidth=4



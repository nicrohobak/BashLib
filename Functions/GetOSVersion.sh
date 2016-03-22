#!/bin/bash

#
# GetOSVersion
#


# Function:	GetOSVersion
# Params:	(None)
# Output:	String (the OS type), or Error Message
function GetOSVersion
{
	local OS="UnknownOS"
	local ERROR="0"

	# Find the major type first
	if [ "`which lsb_release 2> /dev/null`" != "" ]; then
		local DIST_ID=`lsb_release -i | awk '{ print $3; }'`
		local VERSION=`lsb_release -r | awk '{ print $2; }' | sed 's/\..*//'`
		OS="${DIST_ID}-${VERSION}"
	elif [ -e "/etc/debian_version" ]; then
		OS="Debian-`cat /etc/debian_version | sed 's/\..*//'`"
	elif [ -e "/etc/centos-release" ]; then
		OS="`cat /etc/centos-release | awk '{ print $1; }' | sed 's/\..*//'`"
		OS="${OS}-`cat /etc/centos-release | awk '{ print $3; }' | sed 's/\..*//'`"
	else
		ERROR="1"
	fi

	Print "$OS"
	return $ERROR
}


# vim: tabstop=4 shiftwidth=4



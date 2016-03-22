#!/bin/bash

#
# GetApacheVersion
#


# Function:		GetApacheVersion
# Inputs:		$1 - Path to apache2 binary (Optional)
# Outputs		String (Apache Version Number)
function GetApacheVersion
{
	local APACHE_BIN="/usr/sbin/apache2"

	if [ "$1" != "" ]; then
		APACHE_BIN="$1"
	fi

	if [ ! -e "$APACHE_BIN" ]; then
		Error "GetApacheVersion: No apache binary installed at '$APACHE_BIN'"
		return 1
	fi

	echo `$APACHE_BIN -v | grep version | sed 's/^.*Apache\///' | sed 's/ .*$//'`
	return 0
}


# vim: tabstop=4 shiftwidth=4



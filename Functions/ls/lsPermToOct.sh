#!/bin/bash

#
# lsPermToOct
#


# Function:	lsPermToOct
# Inputs:	$1 - visual permission string from ls command
# Outputs:	Number (Octal representation of permission string)
function lsPermToOct
{
	if [ "$1" == "" ] || [ "${#1}" -lt "10" ]; then
		Error "lsPermToOct: Missing or malformed permission string."
		return 1
	fi

	local USER=${1:1:3}
	local GROUP=${1:4:3}
	local OTHER=${1:7:3}

	local USER_OCT=`_lsPermTriadToNum "$USER"`
	local GROUP_OCT=`_lsPermTriadToNum "$GROUP"`
	local OTHER_OCT=`_lsPermTriadToNum "$OTHER"`

	local STICKY_OCT=0

	if [ "$USER_OCT" -ge "10" ]; then
		USER_OCT=$((USER_OCT - 10))
		STICKY_OCT=$((STICKY_OCT + 4))
	fi

	if [ "$GROUP_OCT" -ge "10" ]; then
		GROUP_OCT=$((GROUP_OCT - 10))
		STICKY_OCT=$((STICKY_OCT + 2))
	fi

	if [ "$OTHER_OCT" -ge "10" ]; then
		OTHER_OCT=$((OTHER_OCT - 10))
		STICKY_OCT=$((STICKY_OCT + 1))
	fi

	echo "${STICKY_OCT}${USER_OCT}${GROUP_OCT}${OTHER_OCT}"

	return 0
}


# vim: tabstop=4 shiftwidth=4



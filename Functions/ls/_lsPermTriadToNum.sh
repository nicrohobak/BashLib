#!/bin/bash

#
# _lsPermTriadToNum
#


# Function:	_lsPermTriadToNum
# Inputs:	$1 - 1 triad from ls visual permission string (rwx)
# Outputs:	Number (octal value, +10 if setuid/setgid/sticky is set)
function _lsPermTriadToNum
{
	if [ "$1" == "" ] || [ "${#1}" -lt "3" ]; then
		Error "_lsPermTriadToNum: Missing or malformed permission triad string."
		return 1
	fi

	local VALUE=0

	if [ "${1:0:1}" == "r" ]; then
		VALUE=$((VALUE + 4))
	fi

	if [ "${1:1:1}" == "w" ]; then
		VALUE=$((VALUE + 2))
	fi

	case "${1:2:1}" in
		x)
			VALUE=$((VALUE + 1))
			;;
		s|t)
			VALUE=$((VALUE + 11))
			;;
		S|T)
			VALUE=$((VALUE + 10))
			;;
	esac

	echo "$VALUE"

	return 0
}


# vim: tabstop=4 shiftwidth=4



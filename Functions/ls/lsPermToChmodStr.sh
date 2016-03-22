#!/bin/bash

#
# lsPermToChmodStr
#


# Function:     lsPermToChmodStr
# Inputs:       $1 - visual permission string from ls command
# Outputs:      String (chmod permission string)
function lsPermToChmodStr
{
	# SOLARIS HACK -- standard tools don't do standard things here...
	#GREP="/usr/xpg4/bin/grep"
	GREP="grep"

	if [ "$1" == "" ] || [ "${#1}" -lt "10" ]; then
		Error "lsPermToChmodStr: Missing or malformed permission string."
		return 1
	fi
	  
	local USER=`echo "${1:1:3}" | sed 's/-//g'`
	local GROUP=`echo "${1:4:3}" | sed 's/-//g'`
	local OTHER=`echo "${1:7:3}" | sed 's/-//g'`

	local STICKY=""

	if [ "`echo "${USER}" | ${GREP} -e "s" -e "S"`" != "" ]; then
		STICKY="u+s"
	else
		STICKY="u-s"
	fi
	  
	if [ "`echo "${GROUP}" | ${GREP} -e "s"`" != "" ]; then
		STICKY="${STICKY},g+ws"
	elif [ "`echo "${GROUP}" | ${GREP} -e "S"`" != "" ]; then
		STICKY="${STICKY},g+s"
	else
		STICKY="${STICKY},g-s"
	fi
	  
	if [ "`echo "${OTHER}" | ${GREP} -e "t"`" != "" ]; then
		STICKY="${STICKY},o+ws"
	elif [ "`echo "${OTHER}" | ${GREP} -e "T"`" != "" ]; then
		STICKY="${STICKY},o+s"
	else
		STICKY="${STICKY},o-s"
	fi
	  
	USER=`echo "${USER}" | sed 's/[sStT]//g'`
	GROUP=`echo "${GROUP}" | sed 's/[sStT]//g'`
	OTHER=`echo "${OTHER}" | sed 's/[sStT]//g'`

	if [ "${USER}" == "" ]; then
		echo -n "u="
	else
		echo -n "u=${USER}"
	fi
	  
	if [ "${GROUP}" == "" ]; then
		echo -n ",g="
	else
		echo -n ",g=${GROUP}"
	fi
	  
	if [ "${OTHER}" == "" ]; then
		echo -n ",o="
	else
		echo -n ",o=${OTHER}"
	fi
	  
	if [ "${STICKY}" != "" ]; then
		echo -n ",${STICKY}"
	fi
	  
	echo ""
	return 0
}


# vim: tabstop=4 shiftwidth=4



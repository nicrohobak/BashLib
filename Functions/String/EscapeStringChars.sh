#!/bin/bash

#
# EscapeStringChars
#


# Function: EscapeStringChars -- Backslash escapes special characters for use
#                                in double-quoted strings
# Params:   $* - The string
# Output:   String (The escaped version of the string)
function EscapeStringChars
{
	if [ "${1}" = "" ]; then
		Error "EscapeStringChars: No input provided."
		return 1
	fi

	local ORIG_STR="$*"
	local NEW_STR=""
	local PREV_CHAR=""

	for (( i = 0; i < ${#ORIG_STR}; ++i )); do
		local CUR_CHAR="${ORIG_STR:${i}:1}"

		case "${CUR_CHAR}" in
			'!'|'$'|'`'|'"')
				if [ "${PREV_CHAR}" = '\' ]; then
					NEW_STR="${NEW_STR}${CUR_CHAR}"
				else
					NEW_STR="${NEW_STR}\\${CUR_CHAR}"
				fi
				;;
			'\')
				NEW_STR="${NEW_STR}\\"
				;;
			*)
				NEW_STR="${NEW_STR}${CUR_CHAR}"
				;;
		esac

		PREV_CHAR="${CUR_CHAR}"
	done

	echo "${NEW_STR}"
	return 0
}


# vim: tabstop=4 shiftwidth=4



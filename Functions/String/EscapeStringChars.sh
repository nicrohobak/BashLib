#!/bin/bash

#
# EscapeStringChars
#


# Function:	EscapeStringChars -- Backslash escapes special characters for use
#                                in double-quoted strings (but, does NOT
#                                attempt to handle exclamation points!)
# Params:	$* - The string
# Output:	String (The escaped version of the string)
function EscapeStringChars
{
	if [ "${1}" = "" ]; then
		Error "EscapeStringChars: No input provided."
		return 1
	fi

	# The exclamation point is specially tricky and is thus not handled here...
	# (The problem usually gets parsed out by the time this function is invoked.)
	local SPECIAL_CHAR_LIST='$`\"'

	local ORIG_STR="$*"
	local NEW_STR=""

	for (( i = 0; i < ${#ORIG_STR}; ++i )); do
		local CUR_CHAR="${ORIG_STR:${i}:1}"

		if [ "${FOUND_SPECIAL}" = "true" ]; then
			NEW_STR="${NEW_STR}${CUR_CHAR}"
			continue
		fi

		local FOUND_SPECIAL="false"
		for (( s = 0; s < ${#SPECIAL_CHAR_LIST}; ++s )); do
			local CUR_SPECIAL="${SPECIAL_CHAR_LIST:${s}:1}"

			if [ "${CUR_CHAR}" = "${CUR_SPECIAL}" ]; then
				NEW_STR="${NEW_STR}"'\'"${CUR_SPECIAL}"
				FOUND_SPECIAL="true"
				break
			fi
		done

		if [ "${FOUND_SPECIAL}" != "true" ]; then
			NEW_STR="${NEW_STR}${CUR_CHAR}"
		fi
	done

	echo "${NEW_STR}"
	return 0
}


# vim: tabstop=4 shiftwidth=4



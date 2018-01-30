#!/bin/bash

#
# EscapeSpecialChars
#


# Function:	EscapeSpecialChars -- Converts a string to lowercase
# Params:	$* - The string
# Output:	String (a lowercase version of the input)
function EscapeSpecialChars
{
	if [ "${1}" = "" ]; then
		Error "EscapeSpecialChars: No input provided."
		return 1
	fi

	local SPECIAL_CHARACTER_LIST="'\"()-!?[]{}<>*&$:;\#|"

	local ORIG_STR="$*"
	local NEW_STR=""

	for (( i = 0; i < ${#ORIG_STR}; ++i )); do
		local CUR_CHAR="${ORIG_STR:${i}:1}"

		local FOUND_SPECIAL="false"
		for (( s = 0; s < ${#SPECIAL_CHARACTER_LIST}; ++s ));
	   	do
			local CUR_SPECIAL="${SPECIAL_CHARACTER_LIST:${s}:1}"

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



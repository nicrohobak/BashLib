#!/bin/bash

#
# EscapeSpecialChars
#


# A global variable so this only has to be auto-detected when empty.  This
# should help speed subsequent calls.  Simply empty this variable to force a
# recalculation when necessary.
BASHLIB_ESCAPE_CHAR_LIST=""


# An additional global to explictly ignore (not escape) specific special
# characters.
BASHLIB_ESCAPE_IGNORE_LIST=""


# Function:	EscapeSpecialChars -- Backslash escapes special characters for use
#                                 in non-quoted strings (but, does NOT
#                                 attempt to handle exclamation points!)
# Params:	$* - The string
# Output:	String (The escaped version of the string)
function EscapeSpecialChars
{
	if [ "${1}" = "" ]; then
		Error "EscapeSpecialChars: No input provided."
		return 1
	fi

	if [ "${BASHLIB_ESCAPE_CHAR_LIST}" = "" ]; then
		# The exclamation point is specially tricky and is thus not handled here...
		# (The problem usually gets parsed out by the time this function is invoked.)
		local SPECIAL_CHAR_LIST='@#$%^&*()_+[]{}|<>,.\/;:`'

		# First, determine what even needs to be escaped with the
		# help of $( print "%q" ... ) (Thanks codeforester of StackExchange)
		for (( i = 0; i < ${#SPECIAL_CHAR_LIST}; ++i )); do
			local TEST_CHAR="${SPECIAL_CHAR_LIST:i:1}"
			local COMPARE_CHAR=""

			printf -v COMPARE_CHAR "%q" "${TEST_CHAR}"

			if [[ "${TEST_CHAR}" != "${COMPARE_CHAR}" ]]; then
				BASHLIB_ESCAPE_CHAR_LIST="${BASHLIB_ESCAPE_CHAR_LIST}${TEST_CHAR}"
			fi
		done
	fi

	local ORIG_STR="$*"
	local NEW_STR=""

	for (( i = 0; i < ${#ORIG_STR}; ++i )); do
		local CUR_CHAR="${ORIG_STR:${i}:1}"

		local FOUND_SPECIAL="false"
		for (( s = 0; s < ${#BASHLIB_ESCAPE_IGNORE_LIST}; ++s )); do
			local CUR_SPECIAL="${BASHLIB_ESCAPE_IGNORE_LIST:${s}:1}"

			if [ "${CUR_CHAR}" = "${CUR_SPECIAL}" ]; then
				FOUND_SPECIAL="true"
				break
			fi
		done

		if [ "${FOUND_SPECIAL}" = "true" ]; then
			NEW_STR="${NEW_STR}${CUR_CHAR}"
			continue
		fi

		for (( s = 0; s < ${#BASHLIB_ESCAPE_CHAR_LIST}; ++s )); do
			local CUR_SPECIAL="${BASHLIB_ESCAPE_CHAR_LIST:${s}:1}"

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



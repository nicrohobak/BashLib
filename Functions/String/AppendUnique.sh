#!/bin/bash

#
# AppendUnique
# Appends new content to a list variable, but only if that content doesn't already exist within
#


# Function:	AppendUnique
# Params:	$1 - Destination Variable
#           $* - Remaining params added to variable (but, only if unique!)
# Output:	(None)
function AppendUnique
{
	if [ "${1}" = "" ]; then
		Error "AppendUnique usage: <DEST> <NEW_CONTENT> [<NEW_CONTENT> ...]"
		return 1
	fi

	local DEST_VAR="${1}"	# Were we plan to put it
	local DEST_VAL="${!1}"	# What it currently contains
	local UNIQUE_VALUES=""	# New/Unique values to add

	shift   # Shift to pop the variable name off of the parameter list

	local CUR_PARAM=""
	for CUR_PARAM in $*; do
		# Skip if empty anyway...
		if [ "${CUR_PARAM}" = "" ]; then
			continue
		fi
	
		# Then check if we're already in the destination variable
		case "${DEST_VAL}" in
			*"${CUR_PARAM}"*)		# Found in the orignal, skip!
				continue
				;;
		esac

		# Then check if we're already added to the new variable
		case "${UNIQUE_VALUES}" in
			*"${CUR_PARAM}"*)		# Found in the new, skip!
				continue
				;;
		esac

		# If we get here, we're unique and need to be added
		Append UNIQUE_VALUES ${CUR_PARAM}
	done

	#
	# WARNING: There's always an inherent security risk when `eval` is used!
	#          This is handy, but use with extreme caution! ('Append' uses it.)
	#
	Append "${DEST_VAR}" "${UNIQUE_VALUES}"

	return 0
}


# vim: tabstop=4 shiftwidth=4



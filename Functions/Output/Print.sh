#!/bin/bash

#
# Print
#


# Function: Print
# Params:   (Accepts 'echo' arguments)
# Output:   'echo' Command Output
function Print
{
	# Save IFS and set to known value so formatting is preserved
	# (trailing spaces not removed, etc.)
	local IFS_SAVE="$IFS"
	IFS='
	'

	echo -e $*

	# Restore IFS to previous state
	IFS="$IFS_SAVE"

	return $?
}


# vim: tabstop=4 shiftwidth=4



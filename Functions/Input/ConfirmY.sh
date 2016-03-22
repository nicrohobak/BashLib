#!/bin/bash

#
# ConfirmY
#


# Function:		ConfirmY - Presents a 'Y/n' prompt for the user
# Params:		$1 - Question
# Output:		Return Code (0 for 'Y', and non-zero for 'N')
# Notes:		This function will not function properly via command substitution (no backticks!)
# Example use:  ConfirmY "Continue?" || (echo "Exiting" && exit 1)
#				-- same behavior as ConfirmN example, but with the positive default response
function ConfirmY
{
	local QUESTION="$1"

	if [ "$QUESTION" == "" ]; then
		Error "No question provided."
		return 1
	fi

	local RESPONSE=""

	while [ "$RESPONSE" == "" ]; do
		read -p "$QUESTION  (Y/n): " -e RESPONSE

		case "$RESPONSE" in
			""|y|Y)
				return 0
				;;
			n|N)
				return 1
				;;
			*)
				Error "Invalid response!  Please answer 'Y' or 'N'."
				RESPONSE=""
				;;
		esac
	done

	Error "End of function 'ConfirmY' reached.  This should be impossible."
	return 1
}


# vim: tabstop=4 shiftwidth=4



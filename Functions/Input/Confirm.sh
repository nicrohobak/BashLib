#!/bin/bash

#
# Confirm
#


# Function:	Confirm - Presents a 'y/n' prompt for the user...will not proceed on a default (NULL)
#					  response
# Params:		$1 - Question
# Output:		Return Code (0 for 'Y', and non-zero for 'N')
# Notes:		This function will not function properly via command substitution (no backticks!)
# Example use:  Confirm "Continue?" || (echo "Exiting" && exit 1)
function Confirm
{
	local QUESTION="$1"

	if [ "$QUESTION" == "" ]; then
		Error "No question provided."
		return 1
	fi

	local RESPONSE=""

	while [ "$RESPONSE" == "" ]; do
		read -p "$QUESTION  (y/n): " -e RESPONSE

		case "$RESPONSE" in
			y|Y)
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

	Error "End of function 'Confirm' reached.  This should be impossible."
	return 1
}


# vim: tabstop=4 shiftwidth=4



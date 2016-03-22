#!/bin/bash

#
# Select
#


# Function:	Select - Presents a list of choices and prompts the user for a selection
# Params:	$1 - Whitespace-separated list of choices
#			$2 - Default choice (optional)
# Output:	Return Code (0 for default option (enter with no choice), anything else is the index
#			of the selection)
function Select
{
	local OPTIONS="$1"
	local DEFAULT_OPTION="$2"
	local DEFAULT="0"

	if [ "$OPTIONS" == "" ]; then
		Error "No options provided."
		return 1
	fi

	local INDEX="0"
	local CHOICE="0"

	while [ 1 ]; do
		Print "\nPlease select from the following options:"

		INDEX="1"
		for OPTION in $OPTIONS; do
			if [ "$OPTION" == "$DEFAULT_OPTION" ]; then
				Print " *  $INDEX) $OPTION"
				DEFAULT="$INDEX"
			else
				Print "    $INDEX) $OPTION"
			fi
			INDEX=$((INDEX + 1))
		done

		Print ""
		read -p "What is your selection? " -e CHOICE

		# First, check for the default choice
		if [ "$CHOICE" == "" ]; then
			if [ "$DEFAULT" == "0" ]; then
				Error "Invalid selection!"
				continue
			else
				return $DEFAULT
			fi
		fi

		INDEX="1"
		# Then, try to find a fully-typed option
		for OPTION in $OPTIONS; do
			if [ "$CHOICE" == "$OPTION" ]; then
				return $INDEX
			fi
			INDEX=$((INDEX + 1))
		done

		case $CHOICE in
			*[!0-9]*)
				Error "Invalid selection!"
				;;
			*)
				if [ "$CHOICE" == "0" ] || [ "$CHOICE" -ge "$INDEX" ]; then
					Print "Invalid selection!"
				else
					return $CHOICE
				fi
				;;
		esac
	done

	Error "End of function 'Select' reached.  This should be impossible."
	return 0
}


# vim: tabstop=4 shiftwidth=4



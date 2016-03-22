#!/bin/bash

#
# VerifyFiles
#


# Function:	VerifyFiles - Verifies that all of the files in the source exist in the destination
# Params:	$1 - Package data directory (source)
#			$2 - Installation directory (dest)
# Output:	String ("Verified" or "Out of Date")
function VerifyFiles
{
	if [ "$1" == "" ] || [ "$2" == "" ]; then
		Error "Missing argument(s)."
		return 1
	fi

	local DATA="$1"
	local TARGET="$2"

	if [ ! -e "$DATA" ]; then
		Error "Data location doesn't exist.  Nothing to install."
		return 1
	fi

	if [ ! -d "$DATA" ]; then
		Error "Data location is not a directory: $DATA"
		return 1
	fi

	if [ ! -e "$TARGET" ]; then
		Error "Installation location doesn't exist: $TARGET"
		return 1
	fi

	if [ ! -d "$TARGET" ]; then
		Error "Installation location is not a directory: $TARGET"
		return 1
	fi

	local DATA_PATH=`GetAbsolutePath "$DATA"`
	local TARGET_PATH=`GetAbsolutePath "$TARGET"`

	local IFS_SAVE="$IFS"
	IFS='
	'

	for FILE in `find "$DATA_PATH" -depth ! -type d`; do
		local FS_PATH=`echo "$FILE" | sed "s,^$DATA_PATH/,,"`

		if [ "$FS_PATH" == "$DATA_PATH" ]; then
			continue
		fi

		# And install the target file
		local DIFF=`diff "$DATA_PATH/$FS_PATH" "$TARGET_PATH/$FS_PATH" 2>&1`

		if [ "$?" != "0" ] || [ "$DIFF" != "" ]; then
			Print "Out of Date"
			IFS="$IFS_SAVE"
			return 0
		fi
	done

	IFS="$IFS_SAVE"

	Print "Verified"
	return 0
}


# vim: tabstop=4 shiftwidth=4



#!/bin/bash

#
# MoveToCache
#


# Function:	MoveToCache - Moves a file/directory to the specified cache location
# Params:	$1 - Cache location
#	 		$2 - File name
# Output:	(None)
function MoveToCache
{
    if [ "$1" == "" ] || [ "$2" == "" ]; then
		Error " Missing argument(s)."
		return 1
    fi
    
    local CACHE="$1"
    local FILE="$2"

    local FULL_FILE_PATH=`GetAbsolutePath "$FILE"`
    local FILE_PATH=`dirname "$FULL_FILE_PATH"`
    local FILE_NAME=`basename "$FILE"`

    local CACHE_PATH=`GetAbsolutePath "$CACHE"`

    if [ ! -d "$CACHE_PATH" ]; then
		Error " Cache location is not a directory."
		return 1
    fi

    local TARGET_PATH="${CACHE_PATH}${FILE_PATH}"
    local FULL_TARGET_PATH="${TARGET_PATH}/${FILE_NAME}"

    # Make sure to do something with the previous version, if it exists
    if [ -e "$TARGET_PATH" ]; then
		Error " An instance of '$FULL_FILE_PATH' already exists in '$FULL_CACHE_PATH'.  Please resolve before continuing."
		return 1
    fi

    # Move the file from the file system into the cache, preserving the path
    mkdir -p "$TARGET_PATH" &> /dev/null

    if [ "$?" != "0" ]; then
		Error " Failed to create '$TARGET_PATH'."
		return 1
    fi

    mv "$FULL_FILE_PATH" "$FULL_TARGET_PATH" &> /dev/null

    if [ "$?" != "0" ]; then
		Error " Failed to move '$FULL_FILE_PATH' to '$FULL_TARGET_PATH'."
		return 1
    fi

    return 0
}


# vim: tabstop=4 shiftwidth=4



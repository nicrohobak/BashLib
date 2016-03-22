#!/bin/bash

#
# RestoreFromCache
#


# Function:	RestoreFromCache -- Moves a file/directory from the specified cache back to the system
# Params:	$1 - Cache location
#			$2 - File to restore from cache
#			$3 - Restore location
# Output:	(None)
function RestoreFromCache
{
    if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ]; then
		Error "Missing argument(s)."
		return 1
    fi

    local CACHE="$1"
    local FILE="$2"
    local RESTORE="$3"

    if [ ! -d "$CACHE" ]; then
		Error " Cache location is not a directory."
		return 1
    fi

    if [ ! -d "$RESTORE" ]; then
		Error " Restore location is not a directory."
		return 1
    fi

    local FULL_FILE_PATH=`GetAbsolutePath "$FILE"`
    local FILE_PATH=`dirname "$FULL_FILE_PATH"`
    local FILE_NAME=`basename "$FILE"`

    local CACHE_PATH=`GetAbsolutePath "$CACHE"`

    local FS_FILE_PATH=`echo "$FILE_PATH" | sed "s,^$CACHE_PATH,,"`

    local BASE_RESTORE_PATH=`GetAbsolutePath "$RESTORE"`
    local RESTORE_PATH="${BASE_RESTORE_PATH}${FS_FILE_PATH}"
    local FULL_RESTORE_PATH="${RESTORE_PATH}/${FILE_NAME}"

    if [ -e "$FULL_RESTORE_PATH" ]; then
		Error "'$FULL_RESTORE_PATH' already exists.  Please resolve before continuting."
		return 1
    fi

    mkdir -p "$RESTORE_PATH" &> /dev/null

    if [ "$?" != "0" ]; then
		Error "Failed to create '$RESTORE_PATH'."
		return 1
    fi

    mv "$FULL_FILE_PATH" "$FULL_RESTORE_PATH" &> /dev/null

    if [ "$?" != "0" ]; then
		Error "Failed to move '$FULL_FILE_PATH' to '$FULL_RESTORE_PATH'."
		return 1
    fi

    # Cleanup the cache of the file itself for sure
    rm -rf "$FULL_FILE_PATH" &> /dev/null

    if [ "$?" != "0" ]; then
		Warn "Failed to remove the cached version at '$FULL_FILE_PATH'."
    fi

    local DIR_CHECK_PATH=`echo "$FILE_PATH" | sed "s,^$CACHE_PATH,,"`

    # And if the containing directory is empty, clean that up too
    while [ "$DIR_CHECK_PATH" != "" ]; do
		#echo "Checking to see if '${CACHE_PATH}${DIR_CHECK_PATH}' is empty..."

		if [ "`ls -A "${CACHE_PATH}${DIR_CHECK_PATH}"`" == "" ]; then
		    #Warn "${CACHE_PATH}${DIR_CHECK_PATH} is empty!"
		    rm -rf "${CACHE_PATH}${DIR_CHECK_PATH}"
		fi

		DIR_CHECK_PATH=`echo "$DIR_CHECK_PATH" | sed "s,/[^/]*$,,"`
    done

    return 0
}


# vim: tabstop=4 shiftwidth=4



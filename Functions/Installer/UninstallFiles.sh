#!/bin/bash

#
# UninstallFiles
#


# Function:	UninstallFiles - Removes everything that exists in our data directory from a target
#							 on the filesystem, moving anything that previously exists in to the
#							 cache location
# Params:	$1 - Package data directory (source)
#			$2 - Installation directory (dest)
#			$3 - Package cache directory (cache)
# Output:	(None)
function UninstallFiles
{
    if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ]; then
		Error "Missing argument(s)."
		return 1
    fi

    local DATA="$1"
    local TARGET="$2"
    local CACHE="$3"

    if [ ! -e "$DATA" ]; then
		Error "Data location doesn't exist.  The original source must be used for reference for uninstallation."
		return 1
    fi

    if [ ! -d "$DATA" ]; then
		Error "Data location is not a directory: $DATA"
		return 1
    fi

    if [ ! -e "$TARGET" ]; then
		Error "Installation location doesn't exist.  Nothing to uninstall."
		return 1
    fi

    if [ ! -d "$TARGET" ]; then
		Error "Installation location is not a directory: $TARGET"
		return 1
    fi

    # If the specified cache directory doesn't exist, just create it
    if [ ! -e "$CACHE" ]; then
		mkdir -p "$CACHE"
    fi

    if [ ! -d "$CACHE" ]; then
		Error "Cache location is not a directory: $CACHE"
		return 1
    fi

    local DATA_PATH=`GetAbsolutePath "$DATA"`
    local TARGET_PATH=`GetAbsolutePath "$TARGET"`
    local CACHE_PATH=`GetAbsolutePath "$CACHE"`

    local TIMESTAMP=`date "+%F_%T"`

    CACHE_PATH="$CACHE_PATH/UNINSTALL_$TIMESTAMP"

    local IFS_SAVE="$IFS"
    IFS='
'

    # Before we do anything else, make sure we can place everything in the cache without stomping over other cached items
    for FILE in `find "$DATA_PATH" -depth ! -type d`; do
		local FS_PATH=`echo "$FILE" | sed "s,^$DATA_PATH/,,"`

		if [ "$FS_PATH" == "$DATA_PATH" ]; then
			continue
		fi

		if [ -e "$CACHE_PATH/$FS_PATH" ]; then
			Error "'$FS_PATH' already exists in '$CACHE_PATH'.  Please resolve before continuing."
			IFS="$IFS_SAVE"
	    return 1
	fi
    done

    # Now that we know the cache is ready, cache the existing version and replace with the desired version
    # Make sure to use -depth to start from the deepest directories first so caching won't accidentally hide installation files
    for FILE in `find "$DATA_PATH" -depth ! -type d`; do
		local FS_PATH=`echo "$FILE" | sed "s,^$DATA_PATH/,,"`

		if [ "$FS_PATH" == "$DATA_PATH" ]; then
		    continue
		fi

		local IMMEDIATE_PARENT=""

		# Check to see if we need to cache the existing version
		if [ -e "$TARGET_PATH/$FS_PATH" ]; then
		    # Create the parent directory (if needed)
		    IMMEDIATE_PARENT=`dirname "$CACHE_PATH/$FS_PATH"`
		    if [ ! -e "$IMMEDIATE_PARENT" ]; then
			mkdir -p "$IMMEDIATE_PARENT"
		    fi

		    cp "$TARGET_PATH/$FS_PATH" "$CACHE_PATH/$FS_PATH"
		fi

		IMMEDIATE_PARENT=`dirname "$TARGET_PATH/$FS_PATH"`

		# And Uninstall the target file
		rm -f "$TARGET_PATH/$FS_PATH"

		# And cleanup the directory it was in, if it is now empty
		if [ "`ls -A "$IMMEDIATE_PARENT"`" == "" ]; then
		    rm -rf "$IMMEDIATE_PARENT"
		fi
	    done

	IFS="$IFS_SAVE"

	return 0
}


# vim: tabstop=4 shiftwidth=4



#!/bin/bash

#
# FatalLog
#


# Function:	FatalLog  -- A "Log" to stderr (accepts 'echo' arguments) that exits the script with an error
# Params:	$* - The message
# Output:	'echo' Command Output to stderr (and exits the script!)
function FatalLog
{
	ErrLog $*
	exit 1
}


# vim: tabstop=4 shiftwidth=4



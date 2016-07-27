#!/bin/bash

#
# Log
#


# Function:	Log  -- A "Print" with a timestamp (accepts 'echo' arguments)
# Params:	$* - The message
# Output:	'echo' Command Output
function Log
{
	Print -n "[`date '+%Y-%m-%d %H:%M:%S'`]: "
	Print $*
	return $?
}


# vim: tabstop=4 shiftwidth=4



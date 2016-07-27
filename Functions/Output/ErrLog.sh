#!/bin/bash

#
# ErrLog
#


# Function:	ErrLog  -- A "Log" to stderr (accepts 'echo' arguments)
# Params:	$* - The message
# Output:	'echo' Command Output to stderr
function ErrLog
{
	Print -n "[`date '+%Y-%m-%d %H:%M:%S'`]: " 1>&2
	Print $* 1>&2
	return $?
}


# vim: tabstop=4 shiftwidth=4



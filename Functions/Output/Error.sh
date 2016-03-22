#!/bin/bash

#
# Error
#


# Function:	Error  -- A "Print" to stderr (accepts echo arguments)
# Params:	$* - The message
# Output:	'echo' Command Output to stderr
function Error
{
	Print -n "[ERROR]: " 1>&2
	Print $* 1>&2
	return $?
}


# vim: tabstop=4 shiftwidth=4



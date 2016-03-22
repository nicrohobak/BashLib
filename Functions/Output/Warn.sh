#!/bin/bash

#
# Warn
#


# Function:	Warn  -- A "Print" to stderr (accepts 'echo' arguments)
# Params:	$* - The message
# Output:	'echo' Command Output to stderr
function Warn
{
	Print -n "[WARNING]: " 1>&2
	Print $* 1>&2
	return $?
}


# vim: tabstop=4 shiftwidth=4



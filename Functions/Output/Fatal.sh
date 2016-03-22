#!/bin/bash

#
# Fatal
#


# Function:	Fatal -- Prints an Error and exits the script with an error
# Params:	$* - The message
# Output:	echo Command Output to stderr (and exits the script!)
function Fatal
{
	Error $*
	exit 1
}


# vim: tabstop=4 shiftwidth=4



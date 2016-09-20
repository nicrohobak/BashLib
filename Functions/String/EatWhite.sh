#!/bin/bash

#
# EatWhite
#


# Function:	EatWhite -- Removes all leading/trailing whitespace characters
# Params:	$* - The string
# Output:	String (a whitespace-trimmed version of the input)
function EatWhite
{
	echo "$*" | sed 's/^\s*//' | sed 's/\s*^//'
}


# vim: tabstop=4 shiftwidth=4



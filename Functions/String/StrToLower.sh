#!/bin/bash

#
# StrToLower
#


# Function:	StrToLower -- Converts a string to lowercase
# Params:	$* - The string
# Output:	String (a lowercase version of the input)
function StrToLower
{
	echo $* | tr '[:upper:]' '[:lower:]'
}


# vim: tabstop=4 shiftwidth=4



#!/bin/bash

#
# PrintVars
#


# Function: PrintVars
# Params:   $@ - Variable names to be displayed (sans '$', just the name)
# Output:   Each variable printed alongside its value
function PrintVars
{
	local CUR_VAR
	for CUR_VAR in ${@}; do
		Print "$(printf "%-32s\t%s" "${CUR_VAR}" "${!CUR_VAR}")"
	done
}


# vim: tabstop=4 shiftwidth=4



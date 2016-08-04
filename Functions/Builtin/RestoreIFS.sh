#!/bin/bash

#
# RestoreIFS
# Restores IFS to the default (' \n\t')
#


# Function:	RestoreIFS
# Params:	(None)
# Output:	(None)
function RestoreIFS
{
	IFS=$( printf " \n\t" )
	return 0
}


# vim: tabstop=4 shiftwidth=4



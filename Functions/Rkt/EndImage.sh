#!/bin/bash

#
# RktEndImage
#


# Function: RktEndImage
# Params:   (None)
# Output:   (Normal acbuild output)
function RktEndImage
{
	sudo ${ACBUILD} end

	if [ "${?}" != "0" ]; then
		Error "Rkt_EndImage: Failed to terminate the image."
		return 1
	fi

	return 0
}


# vim: tabstop=4 shiftwidth=4



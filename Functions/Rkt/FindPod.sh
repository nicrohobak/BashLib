#!/bin/bash

#
# RktFindPod
#


# Function: RktFindPod
# Params:   ${1} - Image keyword (if none is provided, all are returned)
#			${2} - Image state (prepared/running/exited/any/etc.  If none is provided, 'any' is implied.)
# Output:   If found, the shorthand UUID for the prepared pod
function RktFindPod
{
	local IMAGE="${1}"
	local STATE="${2}"

	local HEADERS="IMAGE NAME"

	local FOUND_ID=$( ${RKT} list | grep -v "${HEADERS}" | grep -B 1 "$(${RKT} list | grep -v "${HEADERS}" | grep -A 1 -e "${STATE}" | grep -e "${IMAGE}" | awk '{ print $1; }')" | grep -e "${STATE}" | awk '{ print $1; }' )

	if [ "${FOUND_ID}" = "" ]; then
		Error "RktFindPod: Image not found.  (${IMAGE})"
		return 1
	fi

	Print "${FOUND_ID}"
	return 0
}


# vim: tabstop=4 shiftwidth=4



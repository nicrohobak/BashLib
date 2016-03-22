#!/bin/bash

#
# BashLib BASH Library
#
# Note: All functions return status codes, regardless of the output type.
#       All functions report error messages to stderr, regardless of the
#		output type.
#


##############################################################################
# Configuration
##############################################################################

# Set this library's location
BASHLIB_BASE="/usr/local/share/BashLib"

##############################################################################


##############################################################################
# Include Library Functions
##############################################################################

for FUNC in `ls ${BASHLIB_BASE}/Functions/*.sh`; do
	source $FUNC
done

for FUNC in `ls ${BASHLIB_BASE}/Functions/*/*.sh`; do
	source $FUNC
done

##############################################################################


# vim: tabstop=4 shiftwidth=4



#!/bin/bash

#
# Rkt
#

# General rkt data locations
RKT_DATA_DIR="/var/lib/rkt"
RKT_IMAGE_PATH="${RKT_DATA_DIR}/cas/blob/sha512"        # rkt fetch storage location


# Use these variables to provide your own custom options to these commands

RKT="rkt --dir=${RKT_DATA_DIR}"

ACBUILD="acbuild --debug"


#
# DANGER: This directory location is subject to root-level "rm -rf"!!
#
# The acbuild temporary build directory (acbuild default is './.acbuild')
RKT_ACBUILD_TMP="./.acbuild"
#
# DANGER: This directory location is subject to root-level "rm -rf"!!
#

RKT_ACBUILD_ROOTFS="${RKT_ACBUILD_TMP}/currentaci/rootfs"


# Important Container Path Information
RKT_DEFAULT_ENTRY_PATH="/usr/local/sbin"
RKT_DEFAULT_ENTRY_POINT="container-entry-point"
RKT_CONTAINER_ENTRY_POINT="${RKT_DEFAULT_ENTRY_PATH}/${RKT_DEFAULT_ENTRY_POINT}"


#
# Rkt Container package management assistance
#
RKT_PKGMGR_LIST="default apk apt-get yum pacman"
RKT_PKGMGR_DEFAULT="apk"

# Package manager "install" commands
declare -A RKT_PKGMGR_INSTALL
RKT_PKGMGR_INSTALL["default"]="install"
RKT_PKGMGR_INSTALL["apk"]="add --no-cache"
RKT_PKGMGR_INSTALL["pacman"]="-S"

# Package manager "update" commands
declare -A RKT_PKGMGR_UPDATE
RKT_PKGMGR_UPDATE["default"]="update"
RKT_PKGMGR_UPDATE["apk"]="update --no-cache"
RKT_PKGMGR_UPDATE["pacman"]="-Syy"

# Package manager "clean" commands
declare -A RKT_PKGMGR_CLEAN
RKT_PKGMGR_CLEAN["apt-get"]="clean"


# vim: tabstop=4 shiftwidth=4



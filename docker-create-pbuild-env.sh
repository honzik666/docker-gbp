#!/bin/bash
#
# Purpose: Creates pbuilder chroot for using it with git-buildpackage
# Optional argument specifies the container name. Default is
# pbuilder.RANDOM_NUMBER. The container name will then be used as the
# container tag when commiting the new image with pbuilder created

TMP="$$"
CONTAINER_NAME=${1:-pbuilder.$TMP}
TAG=braiins/gbp

docker run --privileged=true --name=$CONTAINER_NAME -t $TAG /bin/sh -c '\
    DIST=`lsb_release -c -s` ARCH=amd64 git-pbuilder create
'

docker commit $CONTAINER_NAME $TAG:$CONTAINER_NAME

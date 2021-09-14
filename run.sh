#!/bin/bash

set -e

IMAGE_NAME="cs588-ros-simulator:latest"
HOST_WORKSPACE_DIR="/home/ezhang/workspace"

docker build . -t $IMAGE_NAME

XAUTH=/tmp/.docker.xauth
if [ ! -f $XAUTH ]
then
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/' | tail -1)
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi

xhost +local:docker

docker run -it \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --volume="$HOST_WORKSPACE_DIR:/root/workspace" \
    --runtime=nvidia \
    $IMAGE_NAME

xhost -local:docker

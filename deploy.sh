#!/bin/bash

IMAGE_TAG=unmanbearpig/jobomon-rails-app

set -e

if [ $# -eq 0 ]
then
    echo "Please provide docker machine name"
    exit 1
else
    MACHINE_NAME=$1
fi

docker build rails_app -t $IMAGE_TAG

IMG_NAME="rails_app.dockerimg"

echo "Exporting image $IMG_NAME..."
docker save "$IMAGE_TAG" -o "$IMG_NAME"

echo "Exported image $IMG_NAME"
(eval $(docker-machine env $MACHINE_NAME) && docker load -i $IMG_NAME)

echo "Loaded $IMG_NAME into $MACHINE_NAME machine. Restarting worker"
(eval $(docker-machine env $MACHINE_NAME) && docker-compose up --no-deps -d worker)

echo "Removing saved image file $IMG_NAME"
rm $IMG_NAME

#! /bin/bash

IMAGE_NAME="2.3-slim"
docker build -t $IMAGE_NAME docker/images/development
docker run -i -t \
    -p 3000:3000 \
    -v $(pwd):/var/www/twistedchat \
    $IMAGE_NAME  /var/www/twistedchat/docker/images/development/start.sh



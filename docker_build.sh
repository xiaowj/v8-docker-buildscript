#!/bin/sh
# removing old container
docker rm v8docker
# CACHEBUST=`date +%s`
docker build . -t v8_docker --network host
# point v8docker to the latest version
docker run -d --name v8docker v8_docker:latest
# copy results out of the container
docker cp v8docker:/home/docker/v8/v8.zip .

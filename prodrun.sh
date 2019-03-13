#!/bin/bash

DOCKER_NETWORK_NAME="swachalit-net"
MYSQL_IMAGE_NAME="mysql:5.5"
REDIS_IMAGE_NAME="devdb/redis:2.8.19"
MYSQL_VOLUME="swachalit-mysql"
REDIS_VOLUME="swachalit-redis"
SWACHALIT_UPLOADS_VOLUME="swachalit-uploads"
SWACHALIT_IMAGE_NAME="swachalit-app"
CONTAINER_OPTS="-d --network $DOCKER_NETWORK_NAME --restart always"

CONTAINER_MYSQL="db"        # --hostname doesn't work
CONTAINER_REDIS="redis"     # --hostname doesn't work

CONTAINER_APP="swachalit-app"
CONTAINER_WORKER="swachalit-worker"
CONTAINER_SCHEDULER="swachalit-scheduler"

# Update external images
docker pull $MYSQL_IMAGE_NAME
docker pull $REDIS_IMAGE_NAME

# Build our app image
docker build -t $SWACHALIT_IMAGE_NAME .

docker rm --force $CONTAINER_MYSQL
docker rm --force $CONTAINER_REDIS
docker rm --force $CONTAINER_APP
docker rm --force $CONTAINER_WORKER
docker rm --force $CONTAINER_SCHEDULER

# https://docs.docker.com/network/network-tutorial-standalone
docker network rm $DOCKER_NETWORK_NAME
docker network create --driver bridge $DOCKER_NETWORK_NAME

docker volume create $MYSQL_VOLUME
docker volume create $REDIS_VOLUME
docker volume create $SWACHALIT_UPLOADS_VOLUME

# Storage
docker run $CONTAINER_OPTS --hostname db --env-file .env.mysql -v $MYSQL_VOLUME:/var/lib/mysql --name $CONTAINER_MYSQL $MYSQL_IMAGE_NAME
docker run $CONTAINER_OPTS --hostname redis -v $REDIS_VOLUME:/var/lib/redis --name $CONTAINER_REDIS $REDIS_IMAGE_NAME

# App services
docker run $CONTAINER_OPTS --env-file .env -p 8800:8800 -v $SWACHALIT_UPLOADS_VOLUME:/app/public/uploads --name $CONTAINER_APP $SWACHALIT_IMAGE_NAME script/run_docker_app.sh
docker run $CONTAINER_OPTS --env-file .env --name $CONTAINER_WORKER $SWACHALIT_IMAGE_NAME script/run_workers.sh
docker run $CONTAINER_OPTS --env-file .env --name $CONTAINER_SCHEDULER $SWACHALIT_IMAGE_NAME script/run_scheduler.sh

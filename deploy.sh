#!/bin/bash

set -x

BRANCH_NAME=$1
BRANCH_NAME="${BRANCH_NAME#origin/}"

if [ "$BRANCH_NAME" == "dev" ]; then
    DOCKER_IMAGE="ranjithdbas/reactapponedev:dev-latest"
    NODE_ENV="development"
elif [ "$BRANCH_NAME" == "prod" ]; then
    DOCKER_IMAGE="ranjithdbas/reactapponeprod:prod-latest"
    NODE_ENV="production"
else
    echo "Unsupported branch: $BRANCH_NAME"
    exit 1
fi

echo "DOCKER_IMAGE=$DOCKER_IMAGE" > .env
echo "NODE_ENV=$NODE_ENV" >> .env

docker-compose pull
docker-compose up -d


#!/bin/bash

set -x

DOCKERHUB_USER="ranjithdbas"
DOCKER_DEV_REPO="${DOCKERHUB_USER}/reactapponedev"
DOCKER_PROD_REPO="${DOCKERHUB_USER}/reactapponeprod"

BRANCH_NAME=$1
echo "Branch name passed: $BRANCH_NAME"
BRANCH_NAME=${BRANCH_NAME#origin/}

if [ "$BRANCH_NAME" == "dev" ]; then
    IMAGE_TAG="dev-latest"
    IMAGE_NAME="$DOCKER_DEV_REPO:$IMAGE_TAG"
elif [ "$BRANCH_NAME" == "prod" ]; then
    IMAGE_TAG="prod-latest"
    IMAGE_NAME="$DOCKER_PROD_REPO:$IMAGE_TAG"
else
    echo "Unsupported branch: $BRANCH_NAME"
    exit 1
fi

docker build -t $IMAGE_NAME .
docker push $IMAGE_NAME


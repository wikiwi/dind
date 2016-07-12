#!/bin/bash
set -eux

DOCKER_VERSION=${DOCKER_VERSION:-1.11}
IMAGE=${IMAGE:-wikiwi/dind:test}
NETWORK=${NETWORK:-wikiwi_isolated_nw}

cleanup() {
  cid=${cid:-''}
  if [ -n "${cid}" ]; then
    echo Stopping dind..
    docker stop ${cid}
    docker rm ${cid}
  fi

  docker network rm ${NETWORK} || true
}
trap cleanup EXIT

# Build container.
docker build -t ${IMAGE} -f ${DOCKER_VERSION}/Dockerfile ${DOCKER_VERSION}

# Create network.
docker network create ${NETWORK}

# Setup minio as S3 Test Server.
docker pull docker:${DOCKER_VERSION}

# Run dind in debug.
cid=$(docker run -e DOCKER_OPTS='-D' \
           --net ${NETWORK} \
           --name dind \
           --privileged \
           -d \
           ${IMAGE})

# Check if debug mode was set.
docker run --rm -e DOCKER_HOST='tcp://dind:2375' --net ${NETWORK} docker:${DOCKER_VERSION} docker info | grep "Debug mode (server): true"


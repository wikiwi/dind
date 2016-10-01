#!/bin/bash
set -eux

DOCKER_VERSIONS=${DOCKER_VERSIONS:-1.11 1.12}
IMAGE=${IMAGE:-wikiwi/dind:test}
NETWORK=${NETWORK:-wikiwi_isolated_nw}

cleanup() {
  cleanup_container
  cleanup_network
}
trap cleanup EXIT

setup_network() {
  docker network create "${NETWORK}"
}

cleanup_network() {
  docker network rm "${NETWORK}" || true
}

setup_container() {
  DOCKER_VERSION=$1

  # Build container.
  docker build -t "${IMAGE}" -f "${DOCKER_VERSION}/Dockerfile" "${DOCKER_VERSION}"

  # Pull upstream docker client.
  docker pull "docker:${DOCKER_VERSION}"

  # Run dind in debug.
  cid=$(docker run -e DOCKER_OPTS='-D' \
             --net "${NETWORK}" \
             --name dind \
             --privileged \
             -d \
             "${IMAGE}")
}

cleanup_container() {
  cid=${cid:-''}
  if [ -n "${cid}" ]; then
    echo Stopping dind..
    docker stop "${cid}"
    docker rm "${cid}"
  fi
  unset cid
}

run_test() {
  DOCKER_VERSION=$1

  # Check if debug mode was set.
  docker run --rm -e DOCKER_HOST='tcp://dind:2375' --net "${NETWORK}" "docker:${DOCKER_VERSION}" docker info | grep -i "Debug mode (server): true"
}

setup_network

for VERSION in $DOCKER_VERSIONS; do
  setup_container $VERSION
  run_test $VERSION
  cleanup_container
done

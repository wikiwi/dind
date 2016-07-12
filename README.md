# dind
_dind_ is like docker:dind but lets you pass additional command line flags using *DOCKER_OPTS* Environment Variable.

[![Build Status](https://travis-ci.org/wikiwi/dind.svg?branch=travis)](https://travis-ci.org/wikiwi/dind) [![Code Climate](https://codeclimate.com/github/wikiwi/dind/badges/gpa.svg)](https://codeclimate.com/github/wikiwi/dind) [![Docker Hub](https://img.shields.io/docker/pulls/wikiwi/dind.svg)](https://hub.docker.com/r/wikiwi/dind)

## Example

    docker run --privileged -e "DOCKER_OPTS=--storage-driver=overlay" wikiwi/dind

## Docker Hub
Automated build is available at the [Docker Hub](https://hub.docker.com/r/wikiwi/dind).

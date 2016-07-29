# dind
_dind_ is like docker:dind but lets you pass additional command line flags using *DOCKER_OPTS* Environment Variable.

[![Build Status Widget]][Build Status] [![Code Climate Widget]][Code Climate] [![MicroBadger Image Widget]][MicroBadger URL]

[Build Status]: https://travis-ci.org/wikiwi/dind
[Build Status Widget]: https://travis-ci.org/wikiwi/dind.svg?branch=master
[Code Climate]: https://codeclimate.com/github/wikiwi/dind
[Code Climate Widget]: https://codeclimate.com/github/wikiwi/dind/badges/gpa.svg
[MicroBadger URL]: http://microbadger.com/#/images/wikiwi/dind
[MicroBadger Image Widget]: https://images.microbadger.com/badges/image/wikiwi/dind.svg

## Example

    docker run --privileged -e "DOCKER_OPTS=--storage-driver=overlay" wikiwi/dind

## Docker Hub
Automated build is available at the [Docker Hub](https://hub.docker.com/r/wikiwi/dind).

#!/bin/sh
set -e

#disconnect registry from cluster network
docker network disconnect "kind" "kind-registry"

kind delete clusters "playground"

docker stop "kind-registry"
docker rm "kind-registry"
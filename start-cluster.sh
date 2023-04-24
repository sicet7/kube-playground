#!/bin/sh
set -e

EXEC_PATH="$(cd "$(dirname "$0")" >/dev/null 2>&1; pwd -P)";

#start kube registry
docker run -d --restart=always -p "127.0.0.1:5001:5000" --name "kind-registry" -v kind-registry-data:/var/lib/registry registry:2

#make sure we can port-forward with kubectl
sudo setcap CAP_NET_BIND_SERVICE=+eip "$(which kubectl)"

kind create cluster --config="$EXEC_PATH/playground.yml"

#connect registry to cluster networking
docker network connect "kind" "kind-registry"

#apply registry config map.
kubectl apply -f "$EXEC_PATH/configMaps/registry.yml"
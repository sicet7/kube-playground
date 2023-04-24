#!/bin/sh
set -e

docker build -t localhost:5001/test-app:latest .
docker push localhost:5001/test-app:latest
docker image rm localhost:5001/test-app:latest
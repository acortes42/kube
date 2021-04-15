#!/bin/sh

echo "\n\033[1;95m Docker build: Grafana: \033[m \n"
docker build . -t grafana

#docker run -d --rm -p 3000:3000 --name grafana grafana


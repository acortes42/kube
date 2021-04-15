#!/bin/sh

echo "\n\033[1;95m Docker build: Influxdb: \033[m \n"
docker build . -t influxdb

#docker run -d --rm -p 80:80 -p 443:443 --name influxdb influxdb


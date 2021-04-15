#!/bin/sh

echo "\n\033[1;95m Docker build: Wordpress: \033[m \n"
docker build . -t wordpress
#docker run -d --rm -p 5050:5050 --name wordpress wordpress

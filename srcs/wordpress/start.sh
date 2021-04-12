#!/bin/sh

echo "\n\033[1;95m Docker build: wordpress: \033[m \n"
docker build /Users/acortes-/Desktop/kube/srcs/wordpress -t wordpress
docker run -d --rm -p 5050:5050 --name wordpress wordpress
echo "\n\033[1;95m Docker build: Nginx: \033[m \n"
docker build /Users/acortes-/Desktop/kube/srcs/nginx -t nginx

docker run -d --rm -p 80:80 -p 443:443 --name nginx nginx

#docker run --rm -p 80:80 -p 443:443 --name nginx nginx

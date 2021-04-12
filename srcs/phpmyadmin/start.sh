echo "\n\033[1;95m Docker build: phpmyadmin: \033[m \n"
docker build /Users/acortes-/Desktop/kube/srcs/phpmyadmin -t phpmyadmin

#docker run -d --rm -p 80:80 -p 443:443 --name phpmyadmin phpmyadmin
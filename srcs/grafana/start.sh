echo "\n\033[1;95m Docker build: Grafana: \033[m \n"
docker build /Users/acortes-/Desktop/kube/srcs/grafana -t grafana

#docker run -d --rm -p 80:80 -p 443:443 --name grafana grafana
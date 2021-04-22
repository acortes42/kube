# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: acortes- <acortes-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/13 14:21:10 by acortes-          #+#    #+#              #
#    Updated: 2021/04/22 19:08:50 by acortes-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

image_failture()
{
	if [ $1 != 0 ]
	then
		echo "\n\033[1;95m Error en la creación de la imagen de $2: \033[m \n"
		exit 1
	fi
	echo "\n\033[1;95m Imagen de $2 creada: \033[m \n"
}

service_deployment()
{
	kubectl apply -f ./srcs/mysql-pvc.yaml 1>/dev/null
	kubectl apply -f ./srcs/mysql.yaml 1>/dev/null
	kubectl apply -f ./srcs/wordpress.yaml 1>/dev/null
	kubectl apply -f ./srcs/phpmyadmin.yaml 1>/dev/null
	kubectl apply -f ./srcs/ftps.yaml 1>/dev/null
	kubectl apply -f ./srcs/influxdb-pvc.yaml 1>/dev/null
	kubectl apply -f ./srcs/influxdb.yaml 1>/dev/null
	kubectl apply -f ./srcs/grafana.yaml 1>/dev/null
	kubectl apply -f ./srcs/nginx.yaml 1>/dev/null
}

build_metallb()
{
	echo "\nInstall and configure \033[1mmetallb\033[0m"
	while :;do printf ".";sleep 1;done &
	trap "kill $!" EXIT  
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml 1>/dev/null;
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml 1>/dev/null;
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" 1>/dev/null;
	kubectl apply -f ./srcs/metallb_config.yaml 1>/dev/null;
	disown $! && kill $! && trap " " EXIT
	echo "\033[32;1m [DONE]\n\033[0m"
}

docker_build()
{
	echo "\n\033[1;95m Construyendo las imagenes: \033[m \n"

	# mysql

	docker build ./srcs/mysql/ -t mysql
	#image_failture "$?", "mysql"

	# wordpress

	docker build ./srcs/wordpress/ -t wordpress
	#image_failture "$?" "wordpress"

	# phpmyadmin

	docker build ./srcs/phpmyadmin/ -t phpmyadmin
	#image_failture "$?", "phpmyadmin"

	# influxdb

	docker build ./srcs/influxdb/ -t influxdb
	#image_failture "$?", "infuxdb"

	# grafana

	docker build ./srcs/grafana/ -t grafana
	#image_failture "$?", "grafana"

	# nginx

	docker build ./srcs/nginx/ -t nginx
	#image_failture "$?" "nginx"

	# ftps

	docker build ./srcs/ftps/ -t ftps
	#image_failture "$?", "ftps"

	#echo "\n\033[1;95m Este es error_check: $Error_check \033[m \n"
}

#
#
#	FT_SERVICE
#
#
#

export MINIKUBE_HOME=~/goinfre
echo "\n\033[1;95m Iniciando minikube: \033[m \n"
minikube start  --vm-driver virtualbox  --disk-size 20000 --addons dashboard
MINIKUBE_IP=`minikube ip`

# Instalación de Metallb de la página oficial

build_metallb

eval $(minikube docker-env)

docker_build
service_deployment
eval $(minikube docker-env --unset)
minikube dashboard 1>/dev/null
DASHBOARD_STATUS=$?
while [ $DASHBOARD_STATUS == 119 ]
do 
	minikube dashboard 1>/dev/null
	DASHBOARD_STATUS=$?
done

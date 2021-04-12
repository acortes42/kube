image_failture()
{
	if [ $1 != 0 ]
	then
		echo "\n\033[1;95m Error en la creación de la imagen de $2: \033[m \n"
		#exit 1
	fi
	echo "\n\033[1;95m Imagen de $2 creada: \033[m \n"
}

service_deployment()
{
	kubectl apply -f ./srcs/ftps.yaml
	kubectl apply -f ./srcs/nginx.yaml
	kubectl apply -f ./srcs/telegraf.yaml
	kubectl apply -f ./srcs/wordpress.yaml
}

docker_build()
{
	Error_check=0
	echo "\n\033[1;95m Construyendo las imagenes: \033[m \n"
	sh srcs/nginx/start.sh
	$Error_check = $?
	image_failture "$Error_check" "nginx"
	sh srcs/wordpress/start.sh
	$Error_check = $?
	echo "\n\033[1;95m Este es error_check: $Error_check \033[m \n"
	image_failture $Error_check "wordpress"
	sh srcs/grafana/start.sh
	$Error_check = $?
	image_failture "$Error_check", "grafana"
	sh srcs/ftps/start.sh
	$Error_check = $?
	image_failture "$Error_check", "ftps"
	sh srcs/infuxdb/start.sh
	$Error_check = $?
	image_failture "$Error_check", "infuxdb"
	sh srcs/phpmyadmin/start.sh
	$Error_check = $?
	image_failture "$Error_check", "phpmyadmin"
	sh srcs/telegraf/start.sh
	$Error_check = $?
	image_failture "$Error_check", "telegraf"
	echo "\n\033[1;95m Este es error_check: $Error_check \033[m \n"
	if [ $Error_check != 0 ]
	then
		echo "\n\033[1;95m Vale, aqui fallo algo \033[m \n"
		exit 1
	fi
}

# Esto empieza aqui
#
# Inicio de Minikube
#

echo "\n\033[1;95m Iniciando minikube: \033[m \n"
minikube start  --vm-driver virtualbox  --disk-size 20000 --extra-config=apiserver.service-node-port-range=20-32767 --addons dashboard
MINIKUBE_IP=`minikube ip`

# Instalación de Metallb de la página oficial

echo "\n\033[1;95m Aqui aparece Metaldb: \033[m \n"

kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system

kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml

kubectl get secret -n metallb-system memberlist  > /dev/null 2>&1
if [ $? != 0 ]
then
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
fi
kubectl apply -f ./srcs/metallb_config.yaml

# Creación de las imagenes de docker

docker_build

# Desplegar servicios

service_deployment

#	Inicio del dashboard de kubernetes

# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml

minikube dashboard 1>/dev/null
DASHBOARD_STATUS=$?
while [ $DASHBOARD_STATUS == 119 ]
do 
	minikube dashboard 1>/dev/null
	DASHBOARD_STATUS=$?
done

echo "\n\033[1;95m Ya debería estar en funcionamiento: \033[m \n"
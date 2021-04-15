#!/bin/sh

cd /usr/share/grafana/conf/provisioning/dashboards

SERVICIO=""
SERVICIO="${SERVICIO} mysql"
SERVICIO="${SERVICIO} wordpress"
SERVICIO="${SERVICIO} phpmyadmin"
SERVICIO="${SERVICIO} influxdb"
SERVICIO="${SERVICIO} grafana"
SERVICIO="${SERVICIO} nginx"
SERVICIO="${SERVICIO} ftps"

for NAME in ${SERVICIO}; do
	cp dashboard.json ${NAME}.json
done

sed -i 's/service_name/mysql/g' mysql.json
sed -i 's/service_name/wordpress/g' wordpress.json
sed -i 's/service_name/phpmyadmin/g' phpmyadmin.json
sed -i 's/service_name/influxdb/g' influxdb.json
sed -i 's/service_name/grafana/g' grafana.json
sed -i 's/service_name/nginx/g' nginx.json
sed -i 's/service_name/ftps/g' ftps.json
rm dashboard.json

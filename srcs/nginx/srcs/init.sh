#!/bin/sh

# Sed -i to insert a line before the chosen line
cd /sbin/telegraf/usr/bin
./telegraf -sample-config -input-filter cpu:mem:disk -output-filter influxdb > telegraf.conf
sed -i '112s/.*/  urls = ["http:\/\/influxdb-svc:8086"]/' telegraf.conf
sed -i '116s/.*/  database = "nginx"/' telegraf.conf

sleep 20

# Prepare nginx

adduser -D -g 'www' www
chown -R www:www /var/lib/nginx
sed -i '3s/.*/user www;/' /etc/nginx/nginx.conf

# Prepare openrc

rc-status -a
touch /run/openrc/softlevel

# Start nginx and check if correct

rc-service nginx start
status=$?
if [ $status -ne 0 ];
then
	echo "Failed to start nginx of wordpress: $status"
	exit $status
fi

# Start php-fpm and check if correct

rc-service php-fpm7 start
status=$?
if [ $status -ne 0 ];
then
	echo "Failed to start php of wordpress: $status"
	exit $status
fi

# More telegraf

cd /sbin/telegraf/usr/bin
./telegraf --config telegraf.conf &
sh /sbin/wait_kube.sh nginx telegraf
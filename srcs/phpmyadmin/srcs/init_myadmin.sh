#!/bin/sh

# Sed -i to insert a line before the chosen line
cd /sbin/telegraf/usr/bin
./telegraf -sample-config -input-filter cpu:mem:disk -output-filter influxdb > telegraf.conf
sed -i '112s/.*/  urls = 192.168.99.240:8086' telegraf.conf
sed -i '116s/.*/  database = "mysql"/' telegraf.conf

sleep 20
# Prepare nginx

#mkdir -p /var/lib/nginx/www/wordpress
#adduser -D -g 'www' www
#chown -R www:www /var/lib/nginx
sed -i '3s/.*/user www;/' /etc/nginx/nginx.conf

# Prepare openrc

rc-status -a
touch /run/openrc/softlevel

# Insert user and group in php-fpm / execute wordpress config script

sed -i '23s/.*/user = www/' /etc/php7/php-fpm.d/www.conf
sed -i '24s/.*/group = www/' /etc/php7/php-fpm.d/www.conf

# Start nginx and check if correct

rc-service nginx start
status=$?
if [ $status -ne 0 ];
then
	echo "Failed to start nginx on : $status"
	exit $status
fi

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
sh /sbin/wait_kube.sh php-fpm7 nginx telegraf
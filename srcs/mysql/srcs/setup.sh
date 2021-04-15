#!/bin/sh

# sed -i to insert a line before the chosen line
cd /sbin/telegraf/usr/bin
./telegraf -sample-config -input-filter cpu:mem:disk -output-filter influxdb > telegraf.conf
sed -i '112s/.*/  urls = 192.168.99.240:8086' telegraf.conf
sed -i '116s/.*/  database = "mysql"/' telegraf.conf

mysql_install_db --user=root --datadir=/var/lib/mysql/
mysqld --user=root --bootstrap < /tmp/mariadb-create.sql
mysqld --user=root & sleep 50
./telegraf --config telegraf.conf &
sh /tmp/wait_kube.sh mysqld telegraf
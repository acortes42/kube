#!/bin/sh

#configuracion telegraf
cd /sbin/telegraf/usr/bin
./telegraf -sample-config -input-filter cpu:mem:disk -output-filter influxdb > telegraf.conf
sed -i '112s/.*/  urls = 192.168.99.240:8086' telegraf.conf
sed -i '116s/.*/  database = "grafana"/' telegraf.conf

grafana-cli --homepath "/usr/share/grafana" admin reset-admin-password admin123
sh /sbin/create_datasources.sh
sh /sbin/create_dashboard.sh
cd /usr/share/grafana && /usr/sbin/grafana-server --config=/etc/grafana.ini & sleep 10
cd /sbin/telegraf/usr/bin
./telegraf --config telegraf.conf &
sh /sbin/wait_kube.sh grafana-server telegraf
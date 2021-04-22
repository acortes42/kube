#!/bin/sh

sed -i '247s/.*/    enabled = true/' /etc/influxdb.conf
sed -i '256s/.*/    bind-address = ":8086"/' /etc/influxdb.conf
#configuracion telegraf
cd /sbin/telegraf/usr/bin
./telegraf -sample-config -input-filter cpu:mem:disk -output-filter influxdb > telegraf.conf
sed -i '112s/.*/  urls = ["http:\/\/0.0.0.0:8086"]/' telegraf.conf
sed -i '116s/.*/  database = "influxdb"/' telegraf.conf
influxd --config /etc/influxdb.conf & sleep 10
./telegraf --config telegraf.conf &
sh /sbin/wait_kube.sh influxd telegraf
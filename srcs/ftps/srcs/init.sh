#!/bin/sh

cd /sbin/telegraf/usr/bin
./telegraf -sample-config -input-filter cpu:mem:disk -output-filter influxdb > telegraf.conf
sed -i '112s/.*/  urls = ["http:\/\/influxdb-svc:8086"]/' telegraf.conf
sed -i '116s/.*/  database = "ftps"/' telegraf.conf

sleep 10

rc-status -a
touch /run/openrc/softlevel

# ftp config

adduser --disabled-password --gecos "" admin \
&& mkdir /home/admin/ftp \
&& chown nobody:nogroup /home/admin/ftp \
&& chmod a-w /home/admin/ftp \
&& mkdir /home/admin/ftp/files \
&& chown admin:admin /home/admin/ftp/files

echo -e "$PASS_ADMIN\n$PASS_ADMIN" | passwd admin

#create ssl keys

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt -subj "/C=ES/ST=Madrid/L=Madrid/O=42_network/CN=localhost"
vsftpd /etc/vsftpd/vsftpd.conf &
cd /sbin/telegraf/usr/bin
./telegraf --config telegraf.conf &
sh /sbin/wait_kube.sh vsftpd telegraf
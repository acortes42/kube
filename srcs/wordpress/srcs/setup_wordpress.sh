#!/bin/sh

cd /var/lib/nginx/www/wordpress
/usr/sbin/wp core download
/usr/sbin/wp config create --dbname=wordpress --dbuser=admin --dbpass=123456 --dbhost=mysql-svc
echo "define( 'WP_HOME', 'http://192.168.99.240:5050/' );" >> wp-config.php
echo "define( 'WP_SITEURL', 'http://192.168.99.240:5050/' );" >> wp-config.php
/usr/sbin/wp core install --url=http://localhost:5050 --title=FT_SERVICES --admin_user=wp_admin --admin_password=123456 --admin_email=acortes42@student.42madrid.com --skip-email
/usr/sbin/wp user create user1 user1@ftserver.fr --user_pass=123456 --role=editor
/usr/sbin/wp user create user2 user2@ftserver.fr --user_pass=123456 --role=contributor
/usr/sbin/wp user create user3 user3@ftserver.fr --user_pass=123456 --role=subscriber
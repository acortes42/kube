# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: acortes- <acortes-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/12 17:19:40 by acortes-          #+#    #+#              #
#    Updated: 2021/04/13 20:32:15 by acortes-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update \
	&& apk add wget \
	&& apk add nginx && mkdir -p /run/nginx \
	&& apk add mysql \
	&& apk add mysql-client
RUN apk add openssl && apk add openrc --no-cache
RUN apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-mbstring php7-json php7-session
RUN apk add --no-cache procps

RUN mkdir -p /run/nginx
RUN mkdir -p /var/lib/nginx/www/ \
	&& cd /var/lib/nginx/www/ \
	&& wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& rm phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& mv phpMyAdmin-5.0.2-all-languages phpmyadmin \
	&& adduser -D -g 'www' www \
	&& chown -R www:www /var/lib/nginx

#SSL

RUN mkdir -p /ssl/
RUN openssl req -x509 -nodes -newkey rsa:2048 -keyout /ssl/localhost.key -out /ssl/localhost.crt -days 365 -subj '/CN=localhost'

#INFLUX

RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf

COPY srcs/default.conf /etc/nginx/conf.d/default.conf
COPY srcs/phpmyadmin.inc.php /var/lib/nginx/www//phpmyadmin
COPY srcs/init_myadmin.sh /sbin/
COPY srcs/wait_kube.sh /sbin/
RUN chmod +x /sbin/init_myadmin.sh
RUN chmod +x /sbin/wait_kube.sh 

EXPOSE 5000

ENTRYPOINT ["/sbin/init_myadmin.sh"]
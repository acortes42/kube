# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: acortes- <acortes-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/12 17:22:12 by acortes-          #+#    #+#              #
#    Updated: 2021/04/13 17:49:42 by acortes-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update && apk add wget && apk add openrc --no-cache
RUN apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli \
    php7-zlib php7-curl php7-mbstring php7-json php7-session php-common \
    php-cli php-mbstring php-bz2 php-phar
RUN apk add mysql-client && apk add nginx && mkdir -p /run/nginx && \
    apk --update add php7-ctype && \
    wget -P /tmp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x /tmp/wp-cli.phar && mv /tmp/wp-cli.phar /usr/sbin/wp

# Telegraf

RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf \
	&& apk add --no-cache procps

COPY srcs/init_wp.sh /sbin/
COPY srcs/setup_wordpress.sh /sbin/
COPY srcs/nginx_wp.conf /etc/nginx/conf.d/default.conf
COPY srcs/wait_kube.sh /sbin/
RUN chmod +x /sbin/init_wp.sh
RUN chmod +x /sbin/setup_wordpress.sh
RUN chmod +x /sbin/wait_kube.sh

EXPOSE 5050 

ENTRYPOINT ["/sbin/init_wp.sh"]

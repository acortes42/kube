# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: acortes- <acortes-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/12 17:19:46 by acortes-          #+#    #+#              #
#    Updated: 2021/04/12 20:26:24 by acortes-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

# UPDATE
RUN apk update

# INSTALLATIONS
RUN apk add nginx
RUN apk add openssl && apk add openrc --no-cache
RUN mkdir -p /var/www/html

#TELEGRAF

RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf

#NGINX

RUN rm /etc/nginx/nginx.conf
COPY srcs/nginx.conf etc/nginx/nginx.conf

#SSL

RUN mkdir -p /ssl/
RUN openssl req -x509 -nodes -newkey rsa:2048 -keyout /ssl/cert.key -out /ssl/cert.crt -days 365 -subj '/CN=localhost'

#START
COPY srcs/setup.sh /usr/sbin/
COPY srcs/index.html /var/www/html
RUN chmod 777 /usr/sbin/setup.sh

ENTRYPOINT ["sh", "/usr/sbin/setup.sh"]


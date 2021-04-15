# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: acortes- <acortes-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/12 17:19:46 by acortes-          #+#    #+#              #
#    Updated: 2021/04/13 19:45:36 by acortes-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

# UPDATE
RUN apk update

# INSTALLATIONS
RUN apk add nginx && mkdir -p /run/nginx
RUN apk add openssl && apk add openrc --no-cache

#TELEGRAF

RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf

#SSL

RUN mkdir -p /ssl/
RUN openssl req -x509 -nodes -newkey rsa:2048 -keyout /ssl/cert.key -out /ssl/cert.crt -days 365 -subj '/CN=localhost' && cp /ssl/cert.key /ssl/cert.crt /tmp

#START

RUN mkdir -p /var/lib/nginx/www/hmtl

COPY srcs/index.html /var/lib/nginx/www/html
COPY srcs/init.sh /usr/sbin/
COPY srcs/wait_kube.sh /usr/sbin/
COPY srcs/default.conf /etc/nginx/conf.d/default.conf

RUN chmod +x /usr/sbin/init.sh
RUN chmod +x /usr/sbin/wait_kube.sh

ENTRYPOINT ["sh", "/usr/sbin/init.sh"]


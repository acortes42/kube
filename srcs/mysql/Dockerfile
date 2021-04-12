# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: acortes- <acortes-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/12 17:19:50 by acortes-          #+#    #+#              #
#    Updated: 2021/04/12 17:19:51 by acortes-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk upgrade ; apk add openrc mysql mysql-client

RUN mkdir -p /run/mysqld

COPY srcs/setup.sh /tmp/
RUN chmod +x /tmp/setup.sh
COPY srcs/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY srcs/mariadb-create.sql /tmp/
COPY srcs/wait_kube.sh /tmp/

RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf \
	&& apk add --no-cache procps

EXPOSE 3306

ENTRYPOINT ["/tmp/setup.sh"]
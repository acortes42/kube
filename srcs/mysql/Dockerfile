# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: acortes- <acortes-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/12 17:19:50 by acortes-          #+#    #+#              #
#    Updated: 2021/04/19 19:30:31 by acortes-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk upgrade ; apk add openrc mariadb mariadb-client mariadb-common

RUN mkdir -p /run/mysqld

COPY srcs/setup.sh /tmp/
COPY srcs/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY srcs/mariadb-create.sql /tmp/
COPY srcs/wait_kube.sh /tmp/

RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf \
	&& apk add --no-cache procps

RUN chmod +x /tmp/setup.sh
RUN chmod +x /tmp/wait_kube.sh

EXPOSE 3306

ENTRYPOINT ["/tmp/setup.sh"]
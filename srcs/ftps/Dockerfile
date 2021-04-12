# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: acortes- <acortes-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/12 17:20:13 by acortes-          #+#    #+#              #
#    Updated: 2021/04/12 19:59:13 by acortes-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update && apk upgrade \
	&& apk add vsftpd \
	&& apk add openrc \
	&& apk add openssl \
	&& apk add --no-cache procps

# telegraf

RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf

COPY srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY srcs/init.sh /sbin/
COPY srcs/wait_kube.sh /sbin/
RUN chmod +x /sbin/init.sh
RUN chmod +x /sbin/wait_kube.sh
EXPOSE 20 21 10000-10005

ENTRYPOINT ["/sbin/init.sh"]

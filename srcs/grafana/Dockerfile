# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: acortes- <acortes-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/13 14:13:24 by acortes-          #+#    #+#              #
#    Updated: 2021/04/13 14:27:58 by acortes-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update \
	&& apk upgrade \
	&& wget http://dl-cdn.alpinelinux.org/alpine/v3.13/community/x86_64/grafana-7.3.6-r0.apk \
	&& apk add grafana-7.3.6-r0.apk \
	&& rm grafana-7.3.6-r0.apk \
	&& apk add --no-cache procps

RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf

COPY srcs/init.sh /sbin/
COPY srcs/create_datasources.sh /sbin/
COPY srcs/create_dashboard.sh /sbin/
COPY srcs/wait_kube.sh /sbin/
COPY srcs/dashboard.json /usr/share/grafana/conf/provisioning/dashboards
COPY srcs/dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards
RUN chmod +x /sbin/init.sh
RUN chmod +x /sbin/create_datasources.sh
RUN chmod +x /sbin/create_dashboard.sh
RUN chmod +x /sbin/wait_kube.sh

EXPOSE 3000

ENTRYPOINT ["/sbin/init.sh"]
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: acortes- <acortes-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/12 17:19:57 by acortes-          #+#    #+#              #
#    Updated: 2021/04/12 20:47:22 by acortes-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#eliminar telegraf de ser necesario. Esta funcionando fuera

FROM alpine:3.12

RUN apk update && apk add influxdb

#TELEGRAF

RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf \
	&& apk add --no-cache procps
	
COPY srcs/init.sh /sbin/
COPY srcs/wait_kube.sh /sbin/

RUN chmod +x /sbin/init.sh
RUN chmod +x /sbin/wait_kube.sh

EXPOSE 8086

ENTRYPOINT ["/sbin/init.sh"]
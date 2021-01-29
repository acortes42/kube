FROM alpine:latest

# UPDATE
RUN apk update

# INSTALLATIONS
RUN apk add nginx
RUN apk add openssl

#NGINX

RUN rm /etc/nginx/nginx.conf
COPY srcs/nginx.conf etc/nginx/nginx.conf

#SSL

RUN mkdir -p /ssl/
RUN openssl req -x509 -nodes -newkey rsa:2048 -keyout /ssl/cert.key -out /ssl/cert.crt -days 365 -subj '/CN=localhost'

#Telegraph

#RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.14.0-static_linux_amd64.tar.gz \
#&& tar -xzf telegraf-1.14.0-static_linux_amd64.tar.gz \
#&& chmod +x telegraf/telegraf \
#&& cp telegraf/telegraf /usr/bin/ \
#&& cp telegraf/telegraf.conf /etc/

#START
COPY srcs/setup.sh .
RUN chmod +x setup.sh

EXPOSE 80 443

CMD ./setup.sh

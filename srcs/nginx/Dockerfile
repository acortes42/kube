FROM alpine

# UPDATE
RUN apk update

# INSTALLATIONS
RUN apk add nginx
RUN apk add wget
RUN apk add php7 php7-fpm

#NGINX

COPY srcs/nginx.conf etc/nginx/sites-available/
RUN  ln -s /etc/nginx/sites-available/nginx.conf etc/nginx/sites-enabled/

#SSL

RUN mkdir ~/mkcert && \
  cd ~/mkcert && \
  wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64 && \
  mv mkcert-v1.1.2-linux-amd64 mkcert && \
  chmod +x mkcert && \
./mkcert -install && \
./mkcert localhost

#Telegraph

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.14.0-static_linux_amd64.tar.gz \
&& tar -xzf telegraf-1.14.0-static_linux_amd64.tar.gz \
&& chmod +x telegraf/telegraf \
&& cp telegraf/telegraf /usr/bin/ \
&& cp telegraf/telegraf.conf /etc/

#START

EXPOSE 80 443

CMD ["/bin/bash"]


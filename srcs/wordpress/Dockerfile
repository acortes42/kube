FROM alpine:latest

RUN apk update && apk add wget && mkdir /www
RUN apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-mbstring php7-json php7-session
RUN apk add wget

COPY srcs/wordpress.tar.gz ./
RUN tar -xvf wordpress.tar.gz \
&& mv wordpress/* /www \
&& rm -rf /var/cache/apk/*

COPY srcs/wp-config.php /www/wp-config.php
COPY srcs/setup.sh .

RUN chmod +x setup.sh

EXPOSE 5050

CMD ./setup.sh

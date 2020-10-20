FROM alpine

RUN apk update
RUN apk add vsftpd
RUN apk add openssl

COPY ./srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
RUN mkdir -p /etc/ssl/private/
RUN openssl req -x509 -days 3560 -newkey rsa:4096 -nodes -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem -subj  "/C=/ST=/L=/O=/OU=/CN="

#Telegraph

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.14.0-static_linux_amd64.tar.gz \
&& tar -xzf telegraf-1.14.0-static_linux_amd64.tar.gz \
&& chmod +x telegraf/telegraf \
&& cp telegraf/telegraf /usr/bin/ \
&& cp telegraf/telegraf.conf /etc/

EXPOSE 21

CMD ["/bin/bash"]

printf "secretpwrd1234\nsecretpwrd1234"| adduser -g 'Nginx www user' -h /var/www/ wwwcbz
/usr/sbin/nginx -g 'daemon off;'

service nginx start && \
wait
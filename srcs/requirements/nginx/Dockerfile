FROM    debian:bullseye

RUN     apt update; \
        apt install -y nginx openssl; \
        apt clean

RUN     openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout ${SSL_KEY} \
        -out ${SSL_CERT} \
        -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=localhost"

COPY    conf/index.html ${NGINX_WEB_FOLDER}
COPY    conf/nginx.conf ${NGINX_CONF}

EXPOSE  443
      
CMD     ["nginx", "-g", "daemon off;"]
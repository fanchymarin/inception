FROM    debian:bullseye

ARG     DOMAIN_NAME

RUN     apt update; \
        apt install -y nginx openssl; \
        apt clean

COPY    conf/index.html /usr/share/nginx/html
COPY    conf/nginx.conf /etc/nginx/nginx.conf

RUN     openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/ssl/private/nginx-selfsigned.key \
        -out /etc/ssl/certs/nginx-selfsigned.crt \
        -subj "/C=MO/L=KH/O=1337/OU=student/CN=${DOMAIN_NAME}"

EXPOSE  443
      
CMD     ["nginx", "-g", "daemon off;"]
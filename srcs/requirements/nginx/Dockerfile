FROM    debian:bullseye

ARG     DOMAIN_NAME

COPY    conf/nginx.conf /default

RUN        apt update \
        && apt install nginx openssl -y\
        && apt clean \
        && mv -f /default /etc/nginx/sites-available/ \
        && sed -i "s/DOMAIN_NAME/$DOMAIN_NAME/g" /etc/nginx/sites-available/default \
        && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
           -keyout /etc/ssl/private/nginx-selfsigned.key \
           -out /etc/ssl/certs/nginx-selfsigned.crt \
           -subj "/C=MO/L=KH/O=1337/OU=student/CN=$DOMAIN_NAME"

EXPOSE  443
 
CMD     ["nginx", "-g", "daemon off;"]
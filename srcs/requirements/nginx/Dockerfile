FROM    debian:bullseye

ARG     DOMAIN_NAME

COPY    conf/nginx.conf /nginx.conf

RUN        apt update \
        && apt install -y nginx openssl \
        && apt clean \
        && sed -i "s/DOMAIN_NAME/$DOMAIN_NAME/g" nginx.conf \
        && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
           -keyout /etc/ssl/private/nginx-selfsigned.key \
           -out /etc/ssl/certs/nginx-selfsigned.crt \
           -subj "/C=MO/L=KH/O=1337/OU=student/CN=$DOMAIN_NAME"

EXPOSE  443
      
CMD     ["nginx", "-g", "daemon off;"]
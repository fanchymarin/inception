FROM     debian:bullseye

WORKDIR  /var/www/html

ARG      DOMAIN_NAME
ARG      WP_NAME
ARG      WP_DATABASE
ARG      WP_USER
ARG      WP_PASSWORD
ARG      WP_EMAIL
ARG      WP_ADMIN_USER
ARG      WP_ADMIN_PASSWORD
ARG      WP_ADMIN_EMAIL

COPY     conf/wp-config.php /
COPY     conf/wp-init.sh /

RUN      apt update \
      && apt upgrade \ 
      && apt install php-fpm php-mysql curl -y \
      && chmod -x /wp-init.sh

ENTRYPOINT ["/bin/bash", "/wp-init.sh"]
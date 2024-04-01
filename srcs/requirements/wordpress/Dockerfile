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
COPY     conf/resume.html /

RUN      apt update \
      && apt upgrade -y \ 
      && apt install php-fpm php-mysql curl -y \
      && mkdir -p /var/run/redis/ \
      && chmod 777 /var/run/redis/ \
      && rm -rf * \
      && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
      && chmod +x wp-cli.phar \
      && mv wp-cli.phar /usr/local/bin/wp \
      && wp core download --allow-root \
      && sed -i "s/\$WP_DATABASE/$WP_DATABASE/g" /wp-config.php \
      && sed -i "s/\$WP_USER/$WP_USER/g" /wp-config.php \
      && sed -i "s/\$WP_PASSWORD/$WP_PASSWORD/g" /wp-config.php \
      && chmod -x /wp-init.sh

ENTRYPOINT ["/bin/bash", "/wp-init.sh"]
FROM    debian:bullseye

ARG     DOMAIN_NAME
ARG     WP_NAME
ARG     WP_DATABASE
ARG     WP_USER
ARG     WP_PASSWORD
ARG     WP_EMAIL
ARG     WP_ADMIN_USER
ARG     WP_ADMIN_PASSWORD
ARG     WP_ADMIN_EMAIL

COPY    conf/wp-config.php.dk /wp-config.php.dk

RUN        apt update \
        && apt install -y php-fpm php-mysql curl gettext \
        && apt clean \
        && mkdir /var/www/ \
        && mkdir /var/www/html \
        && cd /var/www/html \
        && rm -rf * \
        && curl -O \
           https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \ 
        && chmod +x wp-cli.phar \
        && mv wp-cli.phar /usr/local/bin/wp \
        && wp core download --allow-root \
        && export WP_DATABASE="${WP_DATABASE}" WP_USER="${WP_USER}" \
           WP_PASSWORD="${WP_PASSWORD}" \
        && envsubst < /wp-config.php.dk > wp-config.php \
        && rm /wp-config.php.dk

RUN        cd /var/www/html \
        && wp core install --url="${DOMAIN_NAME}" --title="${WP_NAME}" \
           --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}" \
           --admin_email="${WP_ADMIN_EMAIL}" --skip-email --allow-root \
        && wp user create "${WP_USER}" "${WP_EMAIL}" --role=author \
           --user_pass="${WP_PASSWORD}" --allow-root \
        && wp theme install astra --activate --allow-root \
        && wp plugin install redis-cache --activate --allow-root \
        && sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' \
           /etc/php/7.3/fpm/pool.d/www.conf \
        && mkdir /run/php \
        && wp redis enable --allow-root

EXPOSE  9000
EXPOSE  3306
      
CMD     ["/usr/sbin/php-fpm7.3", "-F"]
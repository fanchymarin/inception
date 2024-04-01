#!/bin/bash

cp /wp-config.php .
cp /resume.html .
wp core install --url=$DOMAIN_NAME/ --title=$WP_NAME \
    --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
wp plugin install redis-cache --activate --allow-root
wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --allow-root
wp theme install twentytwentyone --activate --allow-root
sed -i 's/\/run\/php\/php7.4-fpm.sock/9000/g' /etc/php/7.4/fpm/pool.d/www.conf
mkdir /run/php
wp redis enable --allow-root
/usr/sbin/php-fpm7.4 -F
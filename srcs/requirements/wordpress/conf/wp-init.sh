#!/bin/bash

cd /var/www/html
rm -rf *
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
wp core download --allow-root
sed -i "s/\$WP_DATABASE/$WP_DATABASE/g" /wp-config.php
sed -i "s/\$WP_USER/$WP_USER/g" /wp-config.php
sed -i "s/\$WP_PASSWORD/$WP_PASSWORD/g" /wp-config.php
mv /wp-config.php .
wp core install --url=$DOMAIN_NAME/ --title=$WP_NAME \
    --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --allow-root
wp theme install twentytwentyone --activate --allow-root
sed -i 's/\/run\/php\/php7.4-fpm.sock/9000/g' /etc/php/7.4/fpm/pool.d/www.conf
mkdir /run/php
/usr/sbin/php-fpm7.4 -F
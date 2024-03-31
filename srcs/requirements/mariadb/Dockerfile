FROM    debian:bullseye

ARG      WP_DATABASE
ARG      WP_USER
ARG      WP_PASSWORD
ARG      WP_ADMIN_PASSWORD

RUN      apt update \
      && apt upgrade -y \ 
      && apt install mariadb-server -y \
      && sed -i 's/127.0.0.1/0.0.0.0/1' /etc/mysql/mariadb.conf.d/50-server.cnf \
      && service mariadb start \
      && mysql -e "CREATE DATABASE IF NOT EXISTS $WP_DATABASE;" \
      && mysql -e "CREATE USER IF NOT EXISTS '$WP_USER'@'%' IDENTIFIED BY '$WP_PASSWORD' ;" \
      && mysql -e "GRANT ALL PRIVILEGES ON $WP_DATABASE.* TO '$WP_USER'@'%' ;" \
      && mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$WP_ADMIN_PASSWORD' ;" \
      && mysql -p$WP_ADMIN_PASSWORD -e "FLUSH PRIVILEGES;"
      
CMD     ["/usr/bin/mysqld_safe"]
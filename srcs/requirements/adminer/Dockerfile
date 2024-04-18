FROM  debian:bullseye

RUN      apt update \
      && apt upgrade -y \ 
      && apt install wget -y \
      && wget https://www.adminer.org/latest.php \
      && mkdir -p /var/www/html \
      && mv latest.php /var/www/html/adminer.php
FROM  debian:bullseye

WORKDIR adminer/

RUN      apt update \
      && apt upgrade -y \
      && apt install wget php php-mysql -y \
      && wget https://www.adminer.org/latest.php \
      && mv latest.php index.php

EXPOSE 8080

ENTRYPOINT ["php", "-S", "[::]:8080", "-t", "/adminer"]

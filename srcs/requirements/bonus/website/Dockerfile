FROM        debian:bullseye

WORKDIR     /var/www/html/

RUN         apt update \
            && apt upgrade -y \
            && apt install apache2 -y

COPY        conf/resume.html index.html

EXPOSE      80

CMD         ["apachectl", "-D", "FOREGROUND"]

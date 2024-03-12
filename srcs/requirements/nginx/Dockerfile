FROM    debian:bullseye

RUN     apt update; \
        apt install -y nginx systemctl; \
        apt clean; \
        mkdir webpage;

COPY    conf/nginx.conf /etc/nginx/
COPY    conf/mysite.conf /etc/nginx/sites-available/
COPY    conf/index.html /webpage

RUN     ln -s /etc/nginx/sites-available/mysite.conf /etc/nginx/sites-enabled/; \
        mv /etc/nginx/sites-enabled/default /etc/nginx/sites-enabled/.default;
        
CMD     ["systemctl", "start", "nginx"]
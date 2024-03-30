FROM    debian:bullseye

RUN      apt update \
      && apt upgrade \ 
      && apt install redis php7.4-redis -y \
      && echo "unixsocket /var/run/redis/redis.sock" >> /etc/redis/redis.conf \
      && echo "unixsocketperm 777" >> /etc/redis/redis.conf \
      && echo "maxmemory 128mb" >> /etc/redis/redis.conf \
      && echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf \
      && echo "save \"\"" >> /etc/redis/redis.conf

CMD     ["redis-server"]
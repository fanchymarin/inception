FROM  debian:bullseye

ARG   FTP_USER
ARG   FTP_PASSWORD

COPY  conf/vsftpd.conf /vsftpd.conf
COPY  conf/entrypoint.sh /entrypoint.sh

RUN      apt update \
      && apt upgrade -y \ 
      && apt install vsftpd -y \
      && chmod +x /entrypoint.sh

EXPOSE 40000-40005
      
ENTRYPOINT   ["/entrypoint.sh"]
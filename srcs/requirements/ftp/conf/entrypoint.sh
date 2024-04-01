#!/bin/bash

cp /vsftpd.conf /etc/vsftpd.conf
service vsftpd start
adduser --gecos "" -q $FTP_USER --disabled-password
chown -R $FTP_USER:$FTP_USER /home/$FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | /usr/sbin/chpasswd &> /dev/null
echo "$FTP_USER" | tee -a /etc/vsftpd.userlist &> /dev/null
chown nobody:nogroup /home/$FTP_USER/ftp
chmod a-w /home/$FTP_USER/ftp
chown $FTP_USER:$FTP_USER /home/$FTP_USER/ftp/files
sed -i "s/\$FTP_USER/$FTP_USER/g" /etc/vsftpd.conf
service vsftpd stop

/usr/sbin/vsftpd
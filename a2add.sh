#!/bin/bash
# Get external parameters
HOST=$1

#Create host conf
sudo touch /etc/apache2/sites-available/${HOST}.conf
sudo printf "IfModule mod_ssl.c>
    <VirtualHost *:443>
    Protocols h2 http/1.1
    ServerAdmin webmaster@localhost
    ServerName ${HOST}
    DocumentRoot /home/${USERNAME}/www/${HOST}
    ErrorLog \${APACHE_LOG_DIR}/${HOST}-error.log

#restart server
sudo a2ensite mysite.local.conf
sudo service apache2 restart


#!/bin/bash
# Get external parameters
HOST=$1
USERNAME=$2
DATA=$3
#create project
sudo mkdir /home/${USERNAME}/Documents/Projects/${HOST}
sudo mkdir /home/${USERNAME}/Documents/ProjectsData/${DATA}
#create host
sudo touch /etc/apache2/sites-available/${HOST}.conf
sudo printf "<IfModule mod_ssl.c>
    <VirtualHost *:443>
    Protocols h2 http/1.1
    ServerAdmin webmaster@localhost
    ServerName ${HOST}
    DocumentRoot /home/${USERNAME}/www/${HOST}
    ErrorLog \${APACHE_LOG_DIR}/${HOST}-error.log
    CustomLog \${APACHE_LOG_DIR}/${HOST}-access.log combined

    SSLEngine on

    SSLCertificateFile	/etc/ssl/certs/ssl-cert-snakeoil.pem
    SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
    SSLProtocol all -SSLv3 -TLSv1 -TLSv1.1

    <FilesMatch \"\.(cgi|shtml|phtml|php)$\">
        SSLOptions +StdEnvVars
    </FilesMatch>
    <Directory /usr/lib/cgi-bin>
        SSLOptions +StdEnvVars
    </Directory>
    <Directory />
        AllowOverride All
    </Directory>
    <Directory /home/${USERNAME}/www/${HOST}>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride all
        Require all granted
    </Directory>
    <FilesMatch \.php$>
    SetHandler \"proxy:unix:/var/run/php/php7.4-fpm.sock|fcgi://localhost/\"
    </FilesMatch>
    </VirtualHost>
</IfModule>" >> /etc/apache2/sites-available/${HOST}.conf

#restart server
sudo a2ensite ${HOST}
sudo service apache2 restart


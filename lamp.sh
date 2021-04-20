#!/bin/bash
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install apache2
sudo apt install apache2 libapache2-mod-fcgid
sudo a2enmod ssl
sudo a2ensite default-ssl
sudo a2enmod alias
sudo a2enmod actions fcgid alias proxy_fcgi
sudo apt install php7.4 php7.4-fpm
sudo apt install software-properties-commom
a2enmod proxy_fcgi setenvif
a2enconf php7.4-fpm
sudo apt install mysql-server
apt install git
a2enmod rewrite
mkdir -p /home/yaroslav/www/namesite
touch  /home/yaroslav/www/namesite/index.php
echo "<?php phpinfo();" >> /home/yaroslav/www/namesite/index.php
touch /etc/apache2/site-avalible/namesite.local.conf
printf "<IfModule mod_ssl.c>
    <VirtualHost *:443>
    Protocols h2 http/1.1
    ServerAdmin webmaster@localhost
    ServerName namesite.local
    DocumentRoot /home/yaroslav/www/namesite
    ErrorLog ${APACHE_LOG_DIR}/namesite.local-error.log
    CustomLog ${APACHE_LOG_DIR}/namesite.local-access.log combined

    SSLEngine on

    SSLCertificateFile	/etc/ssl/certs/ssl-cert-snakeoil.pem
    SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
    SSLProtocol all -SSLv3 -TLSv1 -TLSv1.1

    <FilesMatch \"(cgi|shtml|phtml|php)\"$>
        SSLOptions +StdEnvVars
    </FilesMatch>
    <Directory /usr/lib/cgi-bin>
        SSLOptions +StdEnvVars
    </Directory>
    <Directory />
        AllowOverride All
    </Directory>
    <Directory /home/yaroslav/www/namesite>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride all
        Require all granted
    </Directory>
    <FilesMatch \.php$>
    SetHandler \"proxy:unix:/var/run/php/php7.4-fpm.sock|fcgi://localhost/\"
    </FilesMatch>
    </VirtualHost>
</IfModule>" >> namesite.local.conf
sudo service apache2 restart
service php7.4-fpm restart
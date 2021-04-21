#!/bin/bash
# Get external parameters
HOST=$1

# Add new repositories
sudo add-apt-repository ppa:ondrej/php
sudo apt install software-properties-commom
sudo apt update

# Install utils
sudo apt install git

# Install apache2
sudo apt install apache2
sudo apt install apache2 libapache2-mod-fcgid
sudo a2enmod actions fcgid alias proxy_fcgi ssl setenvif rewrite
sudo a2ensite default-ssl

# Install PHP
sudo apt install php7.4 php7.4-fpm
sudo a2enconf php7.4-fpm

# Install MySQL
sudo apt install mysql-server

# Create project
sudo mkdir -p /home/yaroslav/www/${HOST}
sudo touch  /home/yaroslav/www/${HOST}/index.php
sudo echo "<?php phpinfo();" >> /home/yaroslav/www/${HOST}/index.php
sudo touch /etc/apache2/sites-available/${HOST}.conf
sudo printf "<IfModule mod_ssl.c>
    <VirtualHost *:443>
    Protocols h2 http/1.1
    ServerAdmin webmaster@localhost
    ServerName ${HOST}
    DocumentRoot /home/yaroslav/www/${HOST}
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
    <Directory /home/yaroslav/www/${HOST}>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride all
        Require all granted
    </Directory>
    <FilesMatch \.php$>
    SetHandler \"proxy:unix:/var/run/php/php7.4-fpm.sock|fcgi://localhost/\"
    </FilesMatch>
    </VirtualHost>
</IfModule>" >> /etc/apache2/sites-available/${HOST}.conf

# Restart all
sudo a2ensite mysite.local.conf
sudo service apache2 restart
sudo service php7.4-fpm restart
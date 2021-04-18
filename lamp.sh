#!/bin/bash
sudo apt update
sudo apt install apache2
sudo apt install php7.4 php7.4-fpm
sudo apt install mysql-server
sudo apt install apache2 libapache2-mod-fcgid
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo a2enmod actions fcgid alias proxy_fcgi
sudo a2enmod ssl
sudo a2ensite default-ssl
sudo a2enmod alias
cd /home/yaroslav
mkdir www
cd /home/yaroslav/www
mkdir mysite
cd /home/yaroslav/www/mysite
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz

#!/bin/bash
#
#
echo "Make sure we have the latest updates."
echo "---------------------------------------------------------------"
#
aptitude update && aptitude -y safe-upgrade
#
#
echo "Install misc packages."
echo "---------------------------------------------------------------"
#
#
apt-get -q -y install git-core
#
#
echo "Install Apache2."
echo "---------------------------------------------------------------"
#
#
apt-get -q -y install apache2
#
a2enmod rewrite deflate
#
#
echo "
User vagrant
Group vagrant
" >> /etc/apache2/httpd.conf
echo "Make vagrant owner of /var/www"
echo "--------------------------------------------------------------"
#
#
chown vagrant:vagrant /var/www
#
#
/etc/init.d/apache2 restart
#
#
echo "Installing mysql"
echo "---------------------------------------------------------------"
#
export DEBIAN_FRONTEND=noninteractive
apt-get -q -y install mysql-server
#
#
apt-get install -y php5 php-pear php5-suhosin php5-cli php5-mysql php5-curl php5-memcache
#
#
/etc/init.d/apache2 restart
#
#
echo "Set up Adminer"
echo "---------------------------------------------------------------"
#
mkdir /var/www/adminer
#
#
wget http://www.adminer.org/latest.php -P /var/www/index.php -o index.php
#
#
echo "One final hurrah"
echo "--------------------------------------------------------------"
#
#
aptitude update && aptitude -y safe-upgrade
#
#
reboot
#
#

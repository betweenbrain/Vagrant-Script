#!/bin/bash
#
#
echo "Make sure we have the latest updates."
echo "---------------------------------------------------------------"
#
aptitude update && aptitude -y safe-upgrade
#
echo "Setting the hostname."
echo "---------------------------------------------------------------"
#
echo "vagrant-debian-squeeze" > /etc/hostname
hostname -F /etc/hostname
#
#
echo "Creating admin group and Vagrant user."
echo "---------------------------------------------------------------"
#
groupadd admin
#
sudo usermod -G admin vagrant
#
echo "Add admin group to sudoers and make passwordless."
echo "---------------------------------------------------------------"
#
echo "
Defaults env_keep=\"SSH_AUTH_SOCK\"
%admin ALL=NOPASSWD: ALL
" >> /etc/sudoers
#
#
echo "Install ruby and chef."
echo "---------------------------------------------------------------"
#
#
apt-get -y update
apt-get -y install build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev
cd /tmp
wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p125.tar.gz
tar -xvzf ruby-1.9.3-p125.tar.gz
cd ruby-1.9.3-p125/
./configure --prefix=/usr/local
make
make install
gem install chef ruby-shadow --no-ri --no-rdoc
#
#
echo "Install puppet."
echo "---------------------------------------------------------------"
#
#
sudo apt-get -y install puppet puppetmaster
#
#
echo "Install openssh-server packages."
echo "---------------------------------------------------------------"
#
#
sudo apt-get -y install openssh-server
#
#
echo "Install misc packages."
echo "---------------------------------------------------------------"
#
#
sudo apt-get -y install git-core
#
#
echo "Install Apache2."
echo "---------------------------------------------------------------"
#
#
sudo apt-get -y install apache2
#
sudo a2enmod rewrite deflate
#
#
echo "
User vagrant
Group vagrant
" >> /etc/apache2/httpd.conf
#
#
echo "Installing mysql"
echo "---------------------------------------------------------------"
#
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y mysql-server
#
#
sudo apt-get install -y php5 php-pear php5-suhosin php5-cli php5-mysql php5-curl php5-memcache
#
#
/etc/init.d/apache2 restart
#
#
sudo mkdir /var/www/adminer
#
#
wget http://www.adminer.org/latest.php -P /var/www/index.php -o index.php
#
#
echo "Install vagrant's public keys."
echo "---------------------------------------------------------------"
#
#
sudo chown vagrant:vagrant /var/www
find /var/www/ -type d -exec chmod 755 {} \;
find /var/www/ -type f -exec chmod 644 {} \;
#
#
echo "Install vagrant's public keys."
echo "---------------------------------------------------------------"
#
#
mkdir ~/.ssh/
chmod 0755 ~/.ssh
cd ~/.ssh
wget http://github.com/mitchellh/vagrant/raw/master/keys/vagrant
wget http://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub
mv vagrant.pub authorized_keys
chmod 0644 authorized_keys
#
#
echo "Install virtual box guest additions."
echo "---------------------------------------------------------------"
#
#
sudo apt-get -y install linux-headers-$(uname -r) build-essential dkms
#
sudo apt-get clean
#
#
echo
echo "One final hurrah"
echo "--------------------------------------------------------------"
#
#
aptitude update && aptitude -y safe-upgrade
#
#
sudo reboot
#
#

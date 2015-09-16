#!/bin/bash

echo "Install PHP 56!"
echo "----- ✄ -----------------------"

echo '✩✩✩✩ Add Repositories ✩✩✩✩'
brew tap homebrew/dupes
brew tap josegonzalez/homebrew-php
brew update

echo '✩✩✩✩ MYSQL (mariadb) ✩✩✩✩'
brew install mariadb
#mysql_install_db --verbose --user=`root` --basedir="$(brew --prefix mariadb)" --datadir=/usr/local/var/mysql --tmpdir=/tmp

echo '✩✩✩✩ NGINX ✩✩✩✩'
brew install --with-passenger nginx

echo '-> Download configs'
mkdir /usr/local/etc/nginx/{common,sites-available,sites-enabled}

curl -Lo /usr/local/etc/nginx/nginx.conf https://raw.githubusercontent.com/Happensit/Homebrew-getlooky/master/conf/nginx/nginx.conf

curl -Lo /usr/local/etc/nginx/common/php https://raw.githubusercontent.com/Happensit/Homebrew-getlooky/master/conf/nginx/common/php
curl -Lo /usr/local/etc/nginx/common/drupal https://raw.githubusercontent.com/Happensit/Homebrew-getlooky/master/conf/nginx/common/drupal


# Download Virtual Hosts.
curl -Lo /usr/local/etc/nginx/sites-available/default https://raw.githubusercontent.com/Happensit/Homebrew-getlooky/master/conf/nginx/sites-available/default
curl -Lo /usr/local/etc/nginx/sites-available/drupal.dev https://raw.githubusercontent.com/Happensit/Homebrew-getlooky/master/conf/nginx/sites-available/drupal.dev
curl -Lo /usr/local/etc/nginx/sites-available/getlooky.dev https://raw.githubusercontent.com/Happensit/Homebrew-getlooky/master/conf/nginx/sites-available/getlooky.dev
curl -Lo /usr/local/etc/nginx/sites-available/xhprof.dev https://raw.githubusercontent.com/Happensit/Homebrew-getlooky/master/conf/nginx/sites-available/xhprof.dev

ln -s /usr/local/etc/nginx/sites-available/default /usr/local/etc/nginx/sites-enabled/default
ln -s /usr/local/etc/nginx/sites-available/getlooky.dev /usr/local/etc/nginx/sites-enabled/getlooky.dev
ln -s /usr/local/etc/nginx/sites-available/drupal.dev /usr/local/etc/nginx/sites-enabled/drupal.dev
ln -s /usr/local/etc/nginx/sites-available/xhprof.dev /usr/local/etc/nginx/sites-enabled/xhprof.dev

# Create folder for logs.
rm -rf /usr/local/var/log/{fpm,nginx}
mkdir -p /usr/local/var/log/{fpm,nginx}

echo '✩✩✩✩ PHP + FPM ✩✩✩✩'
brew install freetype jpeg libpng gd
brew install php56 --without-apache --with-mysql --with-fpm --without-snmp
brew link --overwrite php56

echo '✩✩✩✩ Redis ✩✩✩✩'
brew install redis php56-redis

echo '✩✩✩✩ Xdebug ✩✩✩✩'
brew install php56-xdebug

echo 'xdebug.remote_enable=On' >>  /usr/local/etc/php/5.6/conf.d/ext-xdebug.ini
echo 'xdebug.remote_host="localhost"' >>  /usr/local/etc/php/5.6/conf.d/ext-xdebug.ini
echo 'xdebug.remote_port=9002' >>  /usr/local/etc/php/5.6/conf.d/ext-xdebug.ini
echo 'xdebug.remote_handler="dbgp"' >>  /usr/local/etc/php/5.6/conf.d/ext-xdebug.ini

echo '✩✩✩✩ Xhprof ✩✩✩✩'
brew install graphviz php56-xhprof
mkdir /tmp/xhprof
chmod 777 /tmp/xhprof
echo 'xhprof.output_dir=/tmp/xhprof' >>  /usr/local/etc/php/5.6/conf.d/ext-xhprof.ini

curl -Lo /usr/local/etc/nginx/sites-available/xhprof.dev https://raw.githubusercontent.com/Happensit/Homebrew-getlooky/master/conf/nginx/sites-available/xhprof.dev
ln -s /usr/local/etc/nginx/sites-available/xhprof.dev /usr/local/etc/nginx/sites-enabled/xhprof.dev
sudo echo '127.0.0.1 xhprof.dev' >>  /etc/hosts
sudo echo '127.0.0.1 getlooky.dev' >>  /etc/hosts
sudo echo '127.0.0.1 drupal.dev' >>  /etc/hosts
sudo echo '127.0.0.1 xhprof.dev' >>  /etc/hosts


echo '✩✩✩✩ Drush ✩✩✩✩'
brew install drush

echo '✩✩✩✩ Brew-emp ✩✩✩✩'
curl -Lo /usr/local/bin/getlooky https://raw.githubusercontent.com/Happensit/Homebrew-getlooky/master/bin/getlooky
chmod 755 /usr/local/bin/getlooky

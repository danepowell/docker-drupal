#!/bin/bash
echo start
SITE_ROOT=/var/www/sites/default

if [ ! -f $SITE_ROOT/settings.local.php ]; then
/usr/bin/mysqld_safe &
sleep 5s
MYSQL_PASSWORD=`pwgen -c -n -1 12`
DRUPAL_PASSWORD=`pwgen -c -n -1 12`
echo mysql root password: $MYSQL_PASSWORD
echo drupal password: $DRUPAL_PASSWORD
echo $MYSQL_PASSWORD > /mysql-root-pw.txt
echo $DRUPAL_PASSWORD > /drupal-db-pw.txt
if [ ! -f $SITE_ROOT/settings.php ]; then
cp $SITE_ROOT/default.settings.php $SITE_ROOT/settings.php
fi
echo "if (file_exists(__DIR__ . '/settings.local.php')) {include __DIR__ . '/settings.local.php';}" >> $SITE_ROOT/settings.php
sed -e "s/password_here/$DRUPAL_PASSWORD/" /root/settings.local.php > $SITE_ROOT/settings.local.php
mkdir /files
chmod 777 /files
ln -s /files $SITE_ROOT/files

mysqladmin -u root password $MYSQL_PASSWORD
mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE drupal; GRANT ALL PRIVILEGES ON drupal.* TO 'drupal'@'localhost' IDENTIFIED BY '$DRUPAL_PASSWORD'; FLUSH PRIVILEGES;"
killall mysqld
sleep 5s
fi

exit 0

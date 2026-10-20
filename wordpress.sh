#!/bin/bash
rm -rf /var/www/html/*
cd /tmp
wget https://wordpress.org/latest.zip -O latest.zip
unzip -o latest.zip
cp -r wordpress/* /var/www/html/
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

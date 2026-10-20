#!/bin/bash

# Hentikan script jika ada error
set -e

echo "=== MEMULAI INSTALASI LEMP & WORDPRESS ==="

# 1. Update Repository & Install Package
echo "[1/5] Updating repository & installing packages..."
apt update && apt upgrade -y
apt install nginx mariadb-server php-fpm php-mysql php-cli php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip unzip wget -y

# 2. Konfigurasi Database MariaDB
echo "[2/5] Creating MariaDB Database & User..."
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS db_cms;
CREATE USER IF NOT EXISTS 'user_cms'@'localhost' IDENTIFIED BY 'password_db';
GRANT ALL PRIVILEGES ON db_cms.* TO 'user_cms'@'localhost';
FLUSH PRIVILEGES;
EOF

# 3. Download dan Extract WordPress
echo "[3/5] Downloading and extracting WordPress..."
rm -rf /var/www/html/*
cd /tmp
wget https://wordpress.org/latest.zip -O latest.zip
unzip -o latest.zip
cp -r wordpress/* /var/www/html/
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

# 4. Deteksi Socket PHP-FPM dan Konfigurasi Nginx
echo "[4/5] Configuring Nginx Server Block..."
PHP_SOCKET=$(ls /var/run/php/php*-fpm.sock | head -n 1)

cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.php index.html index.htm;

    server_name _;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:$PHP_SOCKET;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

# 5. Test & Restart Service
echo "[5/5] Restarting Nginx & MariaDB..."
nginx -t
systemctl restart nginx mariadb

echo "=== INSTALASI SELESAI 100% WORK! ==="

#!/bin/bash
apt update && apt upgrade -y
apt install nginx mariadb-server php-fpm php-mysql php-cli php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip unzip wget -y

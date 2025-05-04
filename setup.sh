#!/bin/bash

# Instalar dependências
apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git

# Configurar e instalar extensões PHP
docker-php-ext-configure gd --with-freetype --with-jpeg
docker-php-ext-install -j$(nproc) gd pdo pdo_mysql

# Habilitar mod_rewrite
a2enmod rewrite

# Configurar PHP
echo "memory_limit = 512M" > /usr/local/etc/php/conf.d/memory.ini

# Configurar permissões
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html 
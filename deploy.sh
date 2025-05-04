#!/bin/bash

echo "Iniciando deploy do Os-Flix..."

# Parar containers existentes (se existirem)
echo "Verificando containers existentes..."
if docker ps -a | grep -q osflix-web; then
    docker stop osflix-web
    docker rm osflix-web
fi

if docker ps -a | grep -q osflix-db; then
    docker stop osflix-db
    docker rm osflix-db
fi

# Remover rede antiga se existir
echo "Verificando rede..."
if docker network ls | grep -q osflix-network; then
    docker network rm osflix-network
fi

# Criar nova rede
echo "Criando rede..."
docker network create osflix-network

# Criar container do MySQL
echo "Criando container do banco de dados..."
docker run -d \
  --name osflix-db \
  --network osflix-network \
  -p 3307:3306 \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=osflix \
  -e MYSQL_USER=osflix \
  -e MYSQL_PASSWORD=osflix \
  -v osflix_db_data:/var/lib/mysql \
  mysql:5.7

# Aguardar o MySQL iniciar
echo "Aguardando MySQL iniciar..."
sleep 30

# Verificar se a porta 8081 está disponível
if netstat -tuln | grep -q ":8081 "; then
    echo "ERRO: A porta 8081 já está em uso!"
    echo "Parando deploy..."
    docker stop osflix-db
    docker rm osflix-db
    docker network rm osflix-network
    exit 1
fi

# Remover arquivos de configuração antigos
echo "Removendo arquivos de configuração antigos..."
sudo rm -f /www/wwwroot/osflix.facilitaloterias.com.br/.user.ini

# Ajustar permissões no host
echo "Ajustando permissões no host..."
sudo chown -R www-data:www-data /www/wwwroot/osflix.facilitaloterias.com.br
sudo find /www/wwwroot/osflix.facilitaloterias.com.br -type d -exec chmod 755 {} \;
sudo find /www/wwwroot/osflix.facilitaloterias.com.br -type f -exec chmod 644 {} \;

# Criar container do PHP/Apache
echo "Criando container web..."
docker run -d \
  --name osflix-web \
  --network osflix-network \
  -p 8081:80 \
  -v /www/wwwroot/osflix.facilitaloterias.com.br:/var/www/html \
  -e PHP_MEMORY_LIMIT=512M \
  -e MYSQL_HOST=osflix-db \
  -e MYSQL_DATABASE=osflix \
  -e MYSQL_USER=osflix \
  -e MYSQL_PASSWORD=osflix \
  --restart always \
  php:7.4-apache

# Configurar PHP e Apache
echo "Configurando PHP e Apache..."
docker exec osflix-web bash -c "\
  apt-get update && \
  apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    libxml2-dev \
    && \
  docker-php-ext-configure gd --with-freetype --with-jpeg && \
  docker-php-ext-install -j\$(nproc) gd pdo pdo_mysql xml && \
  a2enmod rewrite && \
  echo 'memory_limit = 512M' > /usr/local/etc/php/conf.d/memory.ini && \
  echo 'display_errors = On' > /usr/local/etc/php/conf.d/error-logging.ini && \
  echo 'error_reporting = E_ALL' >> /usr/local/etc/php/conf.d/error-logging.ini && \
  echo 'log_errors = On' >> /usr/local/etc/php/conf.d/error-logging.ini && \
  echo 'error_log = /dev/stderr' >> /usr/local/etc/php/conf.d/error-logging.ini && \
  echo 'ServerName localhost' >> /etc/apache2/apache2.conf && \
  a2enmod headers && \
  a2enmod proxy && \
  a2enmod proxy_http && \
  service apache2 restart"

# Criar arquivo de diagnóstico
echo "<?php phpinfo(); ?>" > /www/wwwroot/osflix.facilitaloterias.com.br/info.php
sudo chown www-data:www-data /www/wwwroot/osflix.facilitaloterias.com.br/info.php
sudo chmod 644 /www/wwwroot/osflix.facilitaloterias.com.br/info.php

# Atualizar configuração do Nginx
echo "Atualizando configuração do Nginx..."
cat > /www/server/panel/vhost/nginx/osflix.facilitaloterias.com.br.conf << 'EOL'
server {
    listen 80;
    server_name osflix.facilitaloterias.com.br;
    root /www/wwwroot/osflix.facilitaloterias.com.br;
    index index.php index.html;
    
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include        fastcgi_params;
        fastcgi_read_timeout 300;
        fastcgi_connect_timeout 300;
    }

    location ~* \.(jpg|jpeg|png|gif|ico|css|js)$ {
        expires 30d;
        access_log off;
        add_header Cache-Control "public";
    }

    location ~ /\. {
        deny all;
        access_log off;
        log_not_found off;
    }
}
EOL

# Recarregar Nginx
echo "Recarregando Nginx..."
nginx -s reload

echo -e "\n=== Deploy concluído! ==="
echo "Para verificar os logs do web server: docker logs osflix-web"
echo "Para verificar os logs do banco de dados: docker logs osflix-db"
echo -e "\nVerificando status dos containers..."
docker ps | grep osflix

echo -e "\nVerificando logs do Apache..."
docker logs osflix-web

echo -e "\nVerificando permissões do diretório..."
ls -la /www/wwwroot/osflix.facilitaloterias.com.br

echo -e "\nTeste o PHP Info em: http://osflix.facilitaloterias.com.br/info.php"
echo -e "Acesse o site em: http://osflix.facilitaloterias.com.br" 
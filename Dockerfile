FROM php:7.4-apache

# Instalar dependências
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo pdo_mysql mysqli zip

# Habilitar mod_rewrite
RUN a2enmod rewrite

# Configurar o PHP
RUN echo "memory_limit = 512M" > /usr/local/etc/php/conf.d/memory.ini

# Configurar o Apache
COPY apache.conf /etc/apache2/sites-available/000-default.conf

# Copiar arquivos do projeto
COPY . /var/www/
COPY src/ /var/www/html/

# Criar diretório cache e ajustar permissões
RUN mkdir -p /var/www/html/cache \
    && chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www \
    && chmod -R 777 /var/www/html/cache

EXPOSE 80

# Comando para iniciar o Apache
CMD ["apache2-foreground"]
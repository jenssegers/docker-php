FROM php:7.1-fpm

RUN apt-get update && \
    apt-get install git unzip libgmp-dev libicu-dev libcurl4-openssl-dev libpng-dev libjpeg-dev libxml2-dev libzip-dev -y && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h && \
    docker-php-ext-install -j$(nproc) pdo pdo_mysql mysqli intl opcache curl gmp mbstring gd simplexml xml zip && \
    pecl install apcu && docker-php-ext-enable apcu && \
    pecl install redis && docker-php-ext-enable redis && \
    curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/bin/composer

FROM composer
FROM php:cli-alpine

RUN apk add --no-cache --virtual .build-deps \
        ${PHPIZE_DEPS} \
        git \
        freetype \
        libpng \
        libjpeg-turbo \
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev \
        icu-dev \
        zlib-dev \
        libzip-dev  \
        gmp-dev && \
    docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) pdo_mysql intl opcache gmp gd zip sockets && \
    pecl install apcu && docker-php-ext-enable apcu && \
    pecl install redis && docker-php-ext-enable redis && \
    apk del ${PHPIZE_DEPS}

COPY --from=composer /usr/bin/composer /usr/bin/composer

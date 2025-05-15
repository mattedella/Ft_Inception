FROM alpine:3.18

# Enable community repository (needed for php81)
RUN echo "https://dl-cdn.alpinelinux.org/alpine/v3.18/main" > /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/v3.18/community" >> /etc/apk/repositories

# Install dependencies
RUN apk update && apk add --no-cache \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-curl \
    php81-json \
    php81-mbstring \
    php81-opcache \
    php81-phar \
    php81-dom \
    php81-exif \
    php81-fileinfo \
    php81-session \
    curl \
    unzip \
    mariadb-client \
    bash

# Increase memory limit
RUN echo "memory_limit = 512M" > /etc/php81/conf.d/00_memory_limit.ini

# Allow PHP-FPM to listen on all interfaces
RUN sed -i 's|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|' /etc/php81/php-fpm.d/www.conf

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Copy custom wp-config.php
COPY config/wp-config.php /tmp/wp-config.php

# Copy custom entrypoint
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh


WORKDIR /var/www/html

ENTRYPOINT ["entrypoint.sh"]

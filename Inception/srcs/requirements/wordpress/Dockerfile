FROM php:8.1-fpm-alpine

# Install necessary dependencies
RUN apk add --no-cache \
    bash \
    mariadb-client \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    && docker-php-ext-configure gd --with-jpeg --with-webp \
    && docker-php-ext-install gd pdo pdo_mysql

# Install wp-cli for command-line WP management
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Set the working directory to the WordPress root
WORKDIR /var/www/html

# Copy the WordPress files
COPY ./wordpress /var/www/html/

# Ensure the right file permissions
RUN chown -R www-data:www-data /var/www/html

# Start PHP-FPM
CMD ["php-fpm"]

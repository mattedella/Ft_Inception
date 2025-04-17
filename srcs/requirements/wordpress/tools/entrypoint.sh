#!/bin/sh
set -e

# Secrets
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
DB_PASSWORD=$(cat /run/secrets/db_password)

# Wait for DB
until mysql -h mariadb -u"$MYSQL_USER" -p"$DB_PASSWORD" "$MYSQL_DATABASE" -e "SELECT 1"; do
  echo "Waiting for DB..."
  sleep 2
done

# Install WordPress if not installed
if ! wp core is-installed --path=/var/www/html; then
  wp core download --path=/var/www/html
  wp config create \
    --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$DB_PASSWORD \
    --dbhost=mariadb \
    --path=/var/www/html \
    --skip-check
  wp core install \
    --url=https://$DOMAIN_NAME \
    --title="Inception" \
    --admin_user=$WP_ADMIN_USER \
    --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL \
    --path=/var/www/html
fi

# Start PHP-FPM
exec php-fpm

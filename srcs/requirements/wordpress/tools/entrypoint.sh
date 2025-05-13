#!/bin/sh
set -e

# Secrets
# In entrypoint.sh
if [ -f "/run/secrets/wp_admin_password.txt" ]; then
  WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password.txt)
else
  echo "wp_admin_password not found!"
  exit 1
fi

# Repeat for other secrets if necessary
if [ -f "/run/secrets/db_password.txt" ]; then
  DB_PASSWORD=$(cat /run/secrets/db_password.txt)
else
  echo "db_password not found!"
  exit 1
fi

echo "starting wordpress..."
# Wait for DB
echo "Waiting for DB..."
for i in {30..0}; do
    if mysqladmin ping -h mariadb --silent; then
        break
    fi
    echo "Waiting for DB..."
    sleep 1
done

if [ "$i" = 0 ]; then
    echo >&2 "MariaDB did not become available in time."
    exit 1
fi

# Proceed with WordPress setup...

if [ ! -f /var/www/html/wp-load.php ]; then
  echo "WordPress not found. Downloading..."

  echo "Cleaning up any partial install..."
  rm -rf /var/www/html/*

  echo "Downloading WordPress core..."
  wp core download --path=/var/www/html/

  echo "Creating wp-config..."
  wp config create \
    --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$DB_PASSWORD \
    --dbhost=$WP_DB_HOST \
    --path=/var/www/html/ \
    --skip-check

  echo "Installing WordPress..."
  wp core install \
    --url=https://$DOMAIN_NAME \
    --title="Inception" \
    --admin_user=$WP_ADMIN_USER \
    --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL \
    --path=/var/www/html/
fi


# Start PHP-FPM
exec php-fpm81 -F

#!/bin/sh
set -e

# Read secrets
if [ -f "/run/secrets/wp_admin_password.txt" ]; then
  WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password.txt)
else
  echo "wp_admin_password not found!"
  exit 1
fi

if [ -f "/run/secrets/db_password.txt" ]; then
  DB_PASSWORD=$(cat /run/secrets/db_password.txt)
else
  echo "db_password not found!"
  exit 1
fi

if [ -f "/run/secrets/db_password.txt" ]; then
  WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password.txt)
else
  echo "wp_user_password not found!"
  exit 1
fi

echo "Waiting for MariaDB to be ready..."
for i in {30..0}; do
    if mysqladmin ping -h mariadb --silent; then
        break
    fi
    echo "Waiting for DB..."
    sleep 2
done

if [ "$i" = 0 ]; then
    echo >&2 "MariaDB did not become available in time."
    exit 1
fi

# Download WordPress if not present
if [ ! -f /var/www/html/wp-load.php ]; then
    echo "Downloading WordPress core..."
    rm -rf /var/www/html/*
    wp core download --path=/var/www/html/ --allow-root
fi

# Create wp-config.php if it doesn't exist
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creating wp-config.php..."
    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="$WP_DB_HOST" \
        --path=/var/www/html/ \
        --skip-check \
        --allow-root
fi

# Check if WordPress is installed
if ! wp core is-installed --path=/var/www/html/ --allow-root; then
    echo "Installing WordPress..."
    wp core install \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --path=/var/www/html/ \
        --allow-root
else
    echo "WordPress already installed, checking admin user..."

    # Check if user exists
    if wp user get "${WP_ADMIN_USER}" --path=/var/www/html/ --allow-root > /dev/null 2>&1; then
        echo "Admin user exists, updating..."
        wp user update "${WP_ADMIN_USER}" \
            --user_pass="${WP_ADMIN_PASSWORD}" \
            --user_email="${WP_ADMIN_EMAIL}" \
            --role=administrator \
            --allow-root
    else
        echo "Admin user not found, creating..."
        wp user create "${WP_ADMIN_USER}" "${WP_ADMIN_EMAIL}" \
            --user_pass="${WP_ADMIN_PASSWORD}" \
            --role=administrator \
            --allow-root
    fi
    if wp user get "${WP_USER}" --path=/var/www/html/ --allow-root > /dev/null 2>&1; then
        echo "User exists, updating..."
        wp user update "${WP_USER}" \
            --user_pass="${WP_USER_PASSWORD}" \
            --user_email="${WP_USER_EMAIL}" \
            --role=subscriber \
            --allow-root
    else
        echo "User not found, creating..."
        wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
            --user_pass="${WP_USER_PASSWORD}" \
            --role=subscriber \
            --allow-root
    fi
fi


exec php-fpm81 -F

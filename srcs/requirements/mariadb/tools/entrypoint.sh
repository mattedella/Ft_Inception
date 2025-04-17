#!/bin/sh
set -e

# Read passwords from Docker secrets
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_USER_PASSWORD=$(cat /run/secrets/db_password)

# Run default MariaDB entrypoint with env vars set
exec docker-entrypoint.sh mysqld \
  --default-authentication-plugin=mysql_native_password

#!/bin/sh
set -e

# Read passwords from Docker secrets
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password.txt)
MYSQL_USER_PASSWORD=$(cat /run/secrets/db_password.txt)

# Run default MariaDB entrypoint with env vars set
exec entrypoint.sh mysqld \
  --default-authentication-plugin=mysql_native_password

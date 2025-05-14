#!/bin/bash
set -e
set -x

echo "[DEBUG] Entrypoint script started" >&2

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "[DEBUG] Initializing MariaDB data directory..." >&2
    su-exec mysql mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

echo "[DEBUG] Starting temporary MariaDB with --skip-networking..." >&2
su-exec mysql mysqld --skip-networking --socket=/run/mysqld/mysqld.sock &
pid="$!"

# Wait for MariaDB to become ready (via socket)
for i in {30..0}; do
    if mysqladmin --protocol=socket --socket=/run/mysqld/mysqld.sock ping &>/dev/null; then
        break
    fi
    echo "[DEBUG] Waiting for MariaDB to start (via socket)..." >&2
    sleep 1
done

if [ "$i" = 0 ]; then
    echo >&2 "[ERROR] MariaDB failed to start"
    cat /var/lib/mysql/*.err || true
    exit 1
fi

echo "[DEBUG] Running SQL setup..." >&2
mysql --protocol=socket --socket=/run/mysqld/mysqld.sock -u root <<-EOSQL
  CREATE DATABASE IF NOT EXISTS wordpress;
  CREATE USER IF NOT EXISTS 'user123'@'%' IDENTIFIED BY 'password123';
  GRANT ALL PRIVILEGES ON wordpress.* TO 'user123'@'%';
  FLUSH PRIVILEGES;
EOSQL

echo "[DEBUG] Initialization done. Shutting down temp MariaDB..." >&2
mysqladmin --protocol=socket --socket=/run/mysqld/mysqld.sock shutdown

echo "[DEBUG] About to exec mysqld..." >&2
exec mysqld --user=mysql

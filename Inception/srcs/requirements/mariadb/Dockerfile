# mariadb/Dockerfile

FROM mariadb:10.6-alpine

# No passwords are hardcoded here. They are set via environment variables.

# Expose the MariaDB port
EXPOSE 3306

# Default entrypoint for MariaDB to run the database server
ENTRYPOINT ["docker-entrypoint.sh", "mysqld"]

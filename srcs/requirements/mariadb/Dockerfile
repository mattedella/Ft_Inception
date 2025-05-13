FROM alpine:3.18

# Install MariaDB and dependencies
RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client \
    bash \
    curl \
    su-exec


EXPOSE 3306

# Add custom MariaDB config
COPY config/ /etc/my.cnf.d/
RUN chmod 777 /etc/my.cnf.d/*

# Add custom entrypoint
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set entrypoint and command
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

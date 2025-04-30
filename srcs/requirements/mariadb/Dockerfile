FROM alpine:3.18

# Install MariaDB and dependencies
RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client \
    bash \
    curl

# Add custom MariaDB config
COPY config/ /etc/mysql/conf.d/
RUN chmod 644 /etc/mysql/conf.d/*

# Add custom entrypoint
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set entrypoint and command
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["mysqld"]

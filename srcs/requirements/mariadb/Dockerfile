FROM alpine:latest

# Install MariaDB
RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client \
    bash

# Add config
COPY config/ /etc/mysql/conf.d/
RUN chmod 644 /etc/mysql/conf.d/*

# Add custom entrypoint
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["mysqld"]

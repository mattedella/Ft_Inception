openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout etc/ssl/nginx.key \
  -out etc/ssl/nginx.crt \
  -subj "/C=IT/ST=Florence/L=Florence/O=42/OU=Dev/CN=mdella-r.42.fr"

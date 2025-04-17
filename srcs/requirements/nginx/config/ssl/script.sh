openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout nginx.key -out nginx.crt \
  -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=Dev/CN=yourlogin.42.fr"

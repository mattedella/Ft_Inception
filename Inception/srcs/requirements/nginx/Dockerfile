# nginx/Dockerfile

FROM nginx:1.23-alpine

# Install OpenSSL for TLS support
RUN apk add --no-cache openssl

# Copy custom nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Expose only the HTTPS port
EXPOSE 443
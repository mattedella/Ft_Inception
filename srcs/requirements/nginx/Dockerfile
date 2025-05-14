FROM alpine:3.18

# Install nginx and OpenSSL
RUN apk add --no-cache nginx openssl

# Copy custom default.conf (ensure it's valid and inside the correct directory)
COPY ./config/default.conf /etc/nginx/conf.d/default.conf

# Copy SSL files (and script if needed)
COPY ./config/ssl/ /etc/ssl/

# Install OpenSSL and run the script if needed
RUN chmod +x /etc/ssl/script.sh && /etc/ssl/script.sh

# Expose port 443 for HTTPS
EXPOSE 443

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]

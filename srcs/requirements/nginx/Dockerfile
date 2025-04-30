FROM nginx:alpine

# Copy custom default.conf (ensure it's valid and inside the correct directory)
COPY ./config/default.conf /etc/nginx/conf.d/default.conf

# Copy SSL files (and script if needed)
COPY ./config/ssl/ /etc/ssl/

# Install OpenSSL if you plan to run the script.sh
RUN apk add --no-cache openssl \
    && chmod +x /etc/ssl/script.sh && /etc/ssl/script.sh

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]

FROM nginx:alpine

COPY ./config/default.conf /etc/nginx/default.conf
COPY ./config/ssl/ /etc/ssl/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

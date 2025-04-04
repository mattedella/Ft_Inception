# nginx/Dockerfile

FROM debian:latest

RUN apt -y update && apt install -y nginx && apt install openssl -y

COPY ./conf/default /etc/nginx/sites-available/

CMD ["ngnix", "-g", "daemon off;"]
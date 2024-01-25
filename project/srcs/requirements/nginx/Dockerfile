FROM debian:buster

RUN apt-get update && apt-get install -y nginx openssl

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY conf/index.html /var/www/html/index.html

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=FR/ST=Paris/L=paris/O=42/CN=www.jkollner.42.com"


EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]


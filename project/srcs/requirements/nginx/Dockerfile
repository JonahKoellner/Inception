FROM debian:buster

RUN apt-get update && apt-get install -y nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY conf/index.html /var/www/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]


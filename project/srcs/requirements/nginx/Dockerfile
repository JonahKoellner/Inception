FROM debian:11

RUN apt-get update -y
RUN apt-get install nginx -y
RUN apt-get install openssl -y

# COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /etc/nginx/ssl
RUN mkdir -p /run/nginx

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=FR/ST=Paris/L=paris/O=42/CN=www.jkollner.42.com"


EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]


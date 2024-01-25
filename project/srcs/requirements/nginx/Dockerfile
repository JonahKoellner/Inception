FROM debian:latest

RUN apt-get udpate && apt-get install -y nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "deamon off;"]


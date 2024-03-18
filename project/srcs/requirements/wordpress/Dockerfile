FROM debian:11

RUN apt-get update -y 
RUN apt-get upgrade -y

# Install necessary software
RUN apt-get install php7.4-fpm -y
RUN apt-get install php7.4-mysql -y
RUN apt-get install php7.4-mysqli -y
RUN apt-get install curl -y
# for the mysqli admin check for mariadb
RUN apt-get install mariadb-client -y

EXPOSE 9000

COPY ./tools/wp_configure.sh /tmp/wp_configure.sh
RUN chmod +x /tmp/wp_configure.sh

RUN mkdir -p /var/www/html/
WORKDIR /var/www/html/

ENTRYPOINT ["/tmp/wp_configure.sh"]

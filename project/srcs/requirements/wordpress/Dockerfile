FROM debian:buster



RUN apt-get update && apt-get install -y \
	wget \
	unzip \
	apache2 \
	php7.3 \
	php7.3-mysql \
	libapache2-mod-php7.3 \
	php7.3-cli \
	php7.3-cgi \
	php7.3-gd

WORKDIR /var/www/html
RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xzvf latest.tar.gz && \
	rm latest.tar.gz && \
	chown -R www-data:www-data /var/www/html

RUN a2enmod rewrite && \
	service apache2 restart


COPY wp-config.php /var/www/html/wordpress/

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]

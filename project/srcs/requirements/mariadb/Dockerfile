FROM debian:11

RUN apt-get update
RUN apt-get install -y mariadb-server
RUN apt-get install -y mariadb-client
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld \
		&& chown -R mysql:mysql /var/run/mysqld \
		&& chmod 777 /var/run/mysqld

ARG MYSQL_ROOT_PASSWORD

ENV MYSQL_ROOT_PASSWORD=MYSQL_ROOT_PASSWORD

COPY tools/entrypoint.sh /tmp/entrypoint.sh

EXPOSE 3306

RUN chmod +x /tmp/entrypoint.sh

ENTRYPOINT ["/tmp/entrypoint.sh"]


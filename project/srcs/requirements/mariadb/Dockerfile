FROM debian:buster

RUN apt-get update
RUN apt-get install -y mariadb-server
RUN rm -rf /var/lib/apt/lists/*

ARG MYSQL_ROOT_PASSWORD

ENV MYSQL_ROOT_PASSWORD=MYSQL_ROOT_PASSWORD

COPY conf/entrypoint.sh /entrypoint.sh

EXPOSE 3306

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

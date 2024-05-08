FROM debian:11

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install mariadb-server -y
RUN apt-get install mariadb-client -y
# RUN rm -rf /var/lib/apt/lists/*

# RUN mkdir -p /var/run/mysqld \
# 		&& chown -R mysql:mysql /var/run/mysqld \
# 		&& chmod 777 /var/run/mysqld

# ARG MYSQL_ROOT_PASSWORD

# ENV MYSQL_ROOT_PASSWORD=MYSQL_ROOT_PASSWORD

COPY tools/entrypoint.sh /tmp/entrypoint.sh

# EXPOSE 3306

RUN chmod +x /tmp/entrypoint.sh

ENTRYPOINT ["/tmp/entrypoint.sh"]


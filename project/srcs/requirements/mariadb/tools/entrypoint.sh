#!/bin/bash

# set -e

# # Initialize the database if it's the first run
# if [ ! -d "/var/lib/mysql/mysql" ]; then
#   echo "Initializing database..."
#   mysql_install_db --user=mysql --datadir=/var/lib/mysql
#   echo "Database initialized."
# fi

# Start the MariaDB server
#echo "Starting MariaDB server..."
#mysqld_safe --datadir=/var/lib/mysql &

# Wait for MariaDB to start
#sleep  10

if service mariadb start; then
	echo "MariaDB started"
	# Change configuration for the mariadb
	sed -i "s|skip-networking|# skip-networking|g" /etc/mysql/mariadb.conf.d/50-server.cnf
	sed -i "s|*bind-address\s*=.*|# bind-address=0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

	sed -i '/\[client-server\]/a\
            port = 3306\n\
            # socket = /run/mysqld/mysqld.sock\n\
            \n\
            !includedir /etc/mysql/conf.d/\n\
            !includedir /etc/mysql/mariadb.conf.d/\n\
            \n\
            [mysqld]\n\
            user = root\n\
            \n\
            [server]\n\
            bind-address = 0.0.0.0' /etc/mysql/my.cnf

	echo "MariaDB configuration updated"
	# Create the database
	# Delete Standard Database
	# mariadb -u root -p$DB_PASSWORD -e "DROP DATABASE IF EXISTS test;"
	# Create the database if it doesn't exist
	    # Create database if not exists
    mariadb -u root -p$DB_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $DB_DATABASE;"

    # Create user and grant privileges for '%' (any host)
    mariadb -u root -p$DB_PASSWORD -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
    mariadb -u root -p$DB_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USER'@'%';"

    # Create user and grant privileges for 'localhost'
    mariadb -u root -p$DB_PASSWORD -e "CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
    mariadb -u root -p$DB_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USER'@'localhost';"

    mariadb -u root -p$DB_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
    mariadb -u root -p$DB_PASSWORD -e "FLUSH PRIVILEGES;"

    mariadb -u root -p$DB_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '$DB_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
	echo "MariaDB database and user created"

	echo "Stopping MariaDB server..."
	if mysqladmin -u root -p$DB_PASSWORD shutdown; then
		echo "MariaDB stopped"
	else
		echo "MariaDB failed to stop"
	fi
else
	echo "MariaDB failed to start"
fi

if mariadbd --bind-address=0.0.0.0; then
	echo "MariaDB started as deamon"
else
	echo "MariaDB failed to run"
fi


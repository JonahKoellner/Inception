#!/bin/bash


until mysqladmin ping -h"$DB_HOSTNAME" -u"$DB_USER" -p"$DB_PASSWORD" --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 1
done

echo "MariaDB is ready. Proceeding with the script."

echo "-------------------------------------------------"

echo "INFO: Downloading CLI..."

curl -o /usr/local/bin/wp -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x /usr/local/bin/wp

echo "INFO: CLI done"

echo "-------------------------------------------------"

echo "INFO: Downloading WP..."

if [ ! -f "/var/www/html/wp-settings.php" ]; then
    wp core download --allow-root
else
    echo "INFO: WordPress files are already present. Skipping download."
fi

echo "INFO: WP done"

echo "-------------------------------------------------"

if [ ! -f "/var/www/html/wordpress/wp-config.php" ]; then
echo "INFO: MAKING CONFIG..."
    wp config create --dbname="${DB_DATABASE}" \
                    --dbuser="${DB_USER}" \
                    --dbpass="${DB_PASSWORD}" \
                    --dbhost="${DB_HOSTNAME}" \
                    --path="/var/www/html" \
                    --force \
                    --skip-check \
                    --allow-root
echo "INFO: MADE CONFIG"
fi

echo "-------------------------------------------------"

echo "INFO: Installing WordPress..."
while ! wp core install --allow-root \
        --url="https://jkollner.42.fr" \
        --title="Inception" \
        --admin_user="${WP_ADMINNAME}" \
        --admin_password="${WP_ADMINPASS}" \
        --admin_email="${WP_ADMINMAIL}"
do
    echo 1>&2 "Wordpress: Waiting for database ..."
    sleep 1
done
echo "INFO: Installed WordPress"

echo "-------------------------------------------------"

wp option update home "https://jkollner.42.fr" --allow-root
wp option update siteurl "https://jkollner.42.fr" --alllow-root


if ! wp user list --allow-root | grep -q "$WP_USERNAME"; then
    echo "INFO: Setting up ${WP_USERNAME}"
    wp user create "${WP_USERNAME}" \
                    "${WP_USERMAIL}" \
                    --user_pass="$WP_USERPASS" \
                    --allow-root
else
    echo "INFO: ${WP_USERNAME} has already been set up"
fi

echo "-------------------------------------------------"

echo "INFO: Making /run/php dir"

mkdir /run/php

echo "INFO: Made /run/php dir"

echo "-------------------------------------------------"

echo "INFO: Changing FPM configuration"

www_conf_file="/etc/php/7.4/fpm/pool.d/www.conf"

config="[www]\n\
user = www-data\n\
group = www-data\n\
listen = 0.0.0.0:9000\n\
pm = dynamic\n\
pm.max_children = 5\n\
pm.start_servers = 2\n\
pm.min_spare_servers = 1\n\
pm.max_spare_servers = 3\n\
chdir = /\n\
php_admin_value[error_log] = /var/log/php7.4-fpm.log\n\
php_admin_flag[log_errors] = on\n\
php_admin_value[upload_max_filesize] = 100M\n\
php_admin_value[post_max_size] = 100M\n\
security.limit_extensions = .php .php3 .php4 .php5 .php7"

sed -i "s|.*|${config}|g" "$www_conf_file"

echo "INFO: Changed FPM configuration"

echo "-------------------------------------------------"

echo "INFO: Starting FPM"

if /usr/sbin/php-fpm7.4 -F; then
    echo "INFO: Started PHP7.4-FPM"
else
    echo "ERROR: Failed to start PHP7.4-FPM"
fi

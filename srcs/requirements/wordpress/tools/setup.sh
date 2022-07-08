#!bin/bash

set -exo pipefail

sleep 10

# Download Wordpress/php CLI to specified directory and give permissions
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv -f wp-cli.phar /usr/local/bin/wp

# Replace default configuration files with custom ones for Wordpress and php
rm -f /var/www/html/wp-config.php7
rm -f /etc/php7/php-fpm.d/www.conf

cp ./config.php /var/www/html/wp-config.php
cp ./www.conf /etc/php7/php-fpm.d/www.conf

# Exec WP / PHP cli installations, set admin and user
wp core download --allow-root --path="/var/www/html"

wp 	user create \
	--allow-root \
	--path="/var/www/html" \
	${WORDPRESS_USER} \
	"mmondell@mmondell.com" \
	--role=author \
	--user_pass=${WORDPRESS_USER_PWD}
sleep 2

wp 	core install \
	--allow-root \
	--path="/var/www/html" \
	--url=${DOMAIN_NAME} \
	--title=${WORDPRESS_TITLE} \
	--admin_user=${WORDPRESS_ADMIN} \
	--admin_password=${WORDPRESS_ADMIN_PWD} \
	--admin_email=${WORDPRESS_ADMIN_EMAIL} \
	--skip-email

# -> Deamonizer
$@

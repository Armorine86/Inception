#!bin/bash

set -exo pipefail

if [ ! -f "/var/www/html/wp-config.php" ]; then
	wp core download --allow-root --path="/var/www/html"

	rm -f /var/www/html/wp-config.php7
	rm -f /var/www/html/wp-config.php
	rm -f /etc/php7/php-fpm.d/www.conf

	cp ./www.conf /etc/php7/php-fpm.d/www.conf

	if [ "$1" = "php-fpm7" ]; then

		for i in {0..30}; do
			if mariadb -h$DB_SERVER -u$DB_USER -p$DB_USER_PWD --database=$WP_DATABASE <<<'SELECT 1;' &>/dev/null; then
				break
			fi
			sleep 2
		done
	fi


		wp config create \
			--allow-root \
			--dbname=$WP_DATABASE \
			--dbuser=$DB_USER \
			--dbpass=$DB_USER_PWD \
			--dbhost=$DB_SERVER \
			--dbcharset="utf8" \
			--dbcollate="utf8_general_ci" \
			--path="/var/www/html"

		wp 	core install \
			--allow-root \
			--title="${WP_TITLE}" \
			--admin_name="${DB_USER}" \
			--admin_password="${DB_USER_PWD}" \
			--admin_email="wordpress@superuser.com" \
			--skip-email \
			--url="${DOMAIN_NAME}" \
			--path="/var/www/html" 

		wp 	user create \
			--allow-root \
			$WP_USER \
			$WP_USER_EMAIL \
			--role=author \
			--user_pass=$WP_USER_PWD \
			--path="/var/www/html" 

fi

$@

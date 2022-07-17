#!/bin/sh

# if [ ! -e wp-config.php ]; then
wp core download --force --allow-root
sleep 10
wp config create --allow-root \
	--dbname=${WP_DATABASE} \
	--dbuser=${DB_USER_PWD} \
	--dbpass=${DB_USER_PWD} \
	--dbhost=${DB_SERVER}
wp core install --allow-root \
	--url=${DOMAIN_NAME} \
	--title=${WP_TITLE} \
	--admin_user=${WP_ADMIN} \
	--admin_password=${WP_ADMIN_PWD} \
	--admin_email=${WP_ADMIN_EMAIL}
wp user create --allow-root \
	${WP_USER} \
	${WP_USER_EMAIL} \
	--role=subscriber \
	--user_pass=${WP_USER_PWD}
# fi
php-fpm7.3 --nodaemonize

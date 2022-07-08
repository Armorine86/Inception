#!/bin/sh

# if [ ! -e wp-config.php ]; then
wp core download --force --allow-root
sleep 10
wp config create --allow-root \
	--dbname=${MARIA_WORDPRESS_DB} \
	--dbuser=${MARIA_DB_USER} \
	--dbpass=${MARIA_DB_USER_PWD} \
	--dbhost=${DB_SERVER}
wp core install --allow-root \
	--url=${DOMAIN_NAME} \
	--title=${WORDPRESS_TITLE} \
	--admin_user=${WORDPRESS_ADMIN} \
	--admin_password=${WORDPRESS_ADMIN_PWD} \
	--admin_email=${WORDPRESS_ADMIN_EMAIL}
wp user create --allow-root \
	${WORDPRESS_USER} \
	${WORDPRESS_USER_EMAIL} \
	--role=subscriber \
	--user_pass=${WORDPRESS_USER_PWD}
# fi
php-fpm7.3 --nodaemonize

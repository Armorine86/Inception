FROM alpine:3.14

# Expose the port to the network
EXPOSE 9000

ARG DOMAIN_NAME=DOMAIN_NAME
ARG MARIA_WORDPRESS_DB=MARIA_WORDPRESS_DB
ARG MARIA_DB_USER=MARIA_DB_USER
ARG MARIA_DB_USER_PWD=MARIA_DB_USER_PWD
ARG DB_SERVER=DB_SERVER
ARG WORDPRESS_TITLE=WORDPRESS_TITLE
ARG WORDPRESS_ADMIN=WORDPRESS_ADMIN
ARG WORDPRESS_ADMIN_PWD=WORDPRESS_ADMIN_PWD
ARG WORDPRESS_ADMIN_EMAIL=WORDPRESS_ADMIN_EMAIL
ARG WORDPRESS_USER=WORDPRESS_USER
ARG WORDPRESS_USER_EMAIL=WORDPRESS_USER_EMAIL
ARG WORDPRESS_USER_PWD=WORDPRESS_USER_PWD

# Update and upgrade package manager
RUN apk update
RUN apk upgrade

# Copy files to the container
COPY ./tools/* ./

# Make the script executable
RUN chmod +x setup.sh

# Install dependencies
RUN apk add php7 php7-fpm php7-opcache php7-mysqli php7-session php7-iconv php7-json \
	php7-gd php7-curl php7-xml php7-common php7-imap php7-cgi php7-pdo php7-pdo_mysql \
	php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-redis php7-gettext php7-ldap \
	php7-ctype php7-dom php7-phar curl

# add a user profile to the container (-D == no password)
RUN adduser -D mmondell

RUN mkdir -p /var/www/html
RUN chmod 777 -R /var/www/html
RUN chown -R mmondell:mmondell /var/www/html

ENTRYPOINT [ "sh", "setup.sh" ]

CMD ["php-fpm7", "-F"]

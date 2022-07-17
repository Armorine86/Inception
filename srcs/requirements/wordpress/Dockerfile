FROM alpine:3.14

EXPOSE 9000

RUN apk update && apk upgrade

COPY ./tools/* ./
COPY ./conf/* ./

RUN chmod +x setup.sh

RUN apk add php7 php7-fpm php7-opcache php7-mysqli php7-session php7-iconv php7-json \
	php7-gd php7-curl php7-xml php7-common php7-imap php7-cgi php7-pdo php7-pdo_mysql \
	php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-redis php7-gettext php7-ldap \
	php7-ctype php7-dom php7-phar curl bash mariadb-client

RUN adduser -D mmondell

RUN mkdir -p /var/www/html
RUN chmod 777 -R /var/www/html
RUN chown -R mmondell /var/www/html
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN mv -f wp-cli.phar /usr/local/bin/wp


ENTRYPOINT [ "bash", "setup.sh" ]

CMD ["php-fpm7", "-F"]

FROM debian:buster

EXPOSE 9000

# Update and upgrade apt-get
RUN apt update && apt-get upgrade -y
RUN apt-get update && apt-get upgrade -y

RUN mkdir -p /var/www /run/php

COPY ./tools/install_dependencies.sh .
COPY ./tools/configure_wordpress.sh .

RUN chmod +x /install_dependencies.sh
RUN chmod +x /configure_wordpress.sh

RUN ./install_dependencies.sh

RUN rm -f /etc/php/7.3/fpm/pool.d/www.conf
COPY ./tools/www.conf /etc/php/7.3/fpm/pool.d/

# Get and installs the CLI for Wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod a+x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

# Makes PHP listen to port 9000
RUN sed -i '/listen = \/run\/php\/php7.3-fpm.sock/c listen = 9000' /etc/php/7.3/fpm/pool.d/www.conf

RUN chown -R www-data:www-data /var/www

ENTRYPOINT [ "./configure_wordpress.sh" ]

CMD ["php-fpm7.3", "-F", "-R"]

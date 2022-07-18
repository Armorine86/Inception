FROM debian:buster

EXPOSE 9000

RUN apt update && apt upgrade -y

RUN apt-get install -y php7.3-fpm php7.3-mysql mariadb-client curl && rm -rf /var/lib/apt/lists/*

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d

ADD https://wordpress.org/latest.tar.gz /var/www/latest.tar.gz
RUN tar -xvf /var/www/latest.tar.gz && rm -rf latest.tar.gz

RUN	curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/bin/wp
RUN	chmod +x ./usr/bin/wp

RUN mkdir -p /run/php

COPY ./tools/setup_wp.sh .
RUN chmod +x setup_wp.sh

ENTRYPOINT [ "./setup_wp.sh" ]

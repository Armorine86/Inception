FROM debian:buster

EXPOSE 3306

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y mariadb-server mariadb-client gettext

COPY ./tools/setup_db.sh .
RUN chmod +x setup_db.sh

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./conf/db_setup.sql ./db_setup.sql

RUN chown -R mysql:mysql /var/lib/mysql

RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

ENTRYPOINT [ "bash", "setup_db.sh" ]

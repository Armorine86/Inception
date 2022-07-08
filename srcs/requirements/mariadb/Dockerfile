FROM debian:buster

EXPOSE 3306

ENV MARIA_WORDPRESS_DB=wordpress_db
ENV MARIA_DB_NEW_ROOT_PWD=inception
ENV MARIA_DB_USER=wordpress
ENV MARIA_DB_USER_PWD=mmondell1234

# Update and upgrade apt-get
RUN apt update && apt upgrade -y
RUN apt-get update && apt-get upgrade -y

RUN apt-get install mariadb-server -y
RUN apt-get install gettext-base -y

RUN mkdir -p /run/mysql/

RUN chown -R mysql:mysql /run/mysql/

# Set directory ownership to mysql
RUN chown -R mysql:mysql /var/lib/mysql/

# Set the port
RUN sed -Ei '/^(#)?port/c port                    = 3306' /etc/mysql/mariadb.conf.d/50-server.cnf
# Allow remote connections
RUN sed -i '/^bind-address/c bind-address            = 0.0.0.0' /etc/mysql/mariadb.conf.d/50-server.cnf
# Set the datadir
RUN sed -Ei "/^datadir/c datadir                 = /var/lib/mysql/" /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal

# COPY ./tools/my.cnf /etc/mysql/my.cnf

COPY ./tools/db_setup.sql .
COPY ./tools/start.sh .

RUN chmod 777 /var/lib/mysql/
RUN chmod +x ./start.sh

ENTRYPOINT ["./start.sh"]

CMD [ "mysqld" ]

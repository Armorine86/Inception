# Pull base Image for the container
FROM alpine:3.15

# Expose the port for the network
EXPOSE 3306

# Update package manager
RUN apk update && apk upgrade

# Install dependencies
RUN apk add --update mariadb mariadb-common mariadb-client mariadb-server-utils gettext bash

# Replace the default mariadb Config files with our own
RUN rm -f /etc/my.cnf
COPY conf/my.cnf /etc/my.cnf

RUN rm -f /etc/my.cnf.d/my.cnf
COPY conf/my.cnf /etc/mysql/my.cnf


# Copy setup script to the container
RUN mkdir -p tools/
COPY tools/setup.sh tools/setup.sh

# Copy the .sql config file to the container
COPY conf/db_setup.sql db_setup.sql

# Make sure the script is executable
RUN chmod +x tools/setup.sh

# Create Necessary folders for Mariadb, and change ownership
RUN mkdir -p /run/mysqld /var/lib/mysql
RUN chmod 777 /var/lib/mysql
RUN chmod 777 /run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql
RUN chown -R mysql:mysql /run/mysqld

ENTRYPOINT [ "bash", "tools/setup.sh" ]

CMD [ "mysqld" ]

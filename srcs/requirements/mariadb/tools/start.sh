#!/bin/bash

set -exo pipefail

SUCCESS=/var/lib/mysql/.setup_done

if [ -f "$SUCCESS" ]
then
	echo "Database is already configured... Starting MariaDB"
	/usr/bin/mysqld
else
	# Start mysql service
	/etc/init.d/mysql start

	# envsubst is used to substitute shell format strings with environment variables in text.
	# redirect the config with expended variable into initdb.sql
	envsubst < db_setup.sql > initdb.sql

	echo "Starting mysql"
	/usr/bin/mysql

	echo "Attempting to setup mariadb with initdb.sql file as root"
	mariadb -uroot -proot < initdb.sql

	# If setup is successful, create a hidden file to mark setuping as completed
	touch /var/lib/mysql/.setup_done

	echo "Setup successful... Removin initdb.sql file"
	rm initdb.sql
	rm db_setup.sql

	killall mysqld
fi

exec mysqld

#!/bin/bash

set -exo pipefail

SUCCESS=/var/lib/mysql/.setup_done

if [ -f "$SUCCESS" ]
then
	echo "Database is already configured... Starting MariaDB"
	/usr/bin/mysqld
else
	# Start mysql service
	/usr/bin/mysqld --user=root --datadir=/var/lib/mysql
	sleep 5

	# envsubst is used to substitute shell format strings with environment variables in text.
	# redirect the config with expended variable into initdb.sql
	envsubst < db_setup.sql > initdb.sql

	# Kill process
	pkill mysqld
	sleep 2

	# Restart service for changes to take effect
	/usr/bin/mysqld --user=root --datadir=/var/lib/mysql

	# If setup is successful, create a hidden file to mark setuping as completed
	touch /var/lib/mysql/.setup_done

fi

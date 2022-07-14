#!/usr/bin/env sh

set -exo pipefail

SUCCESS=/var/lib/mysql/.setup_done

if [ -f "$SUCCESS" ]
then
	echo "Database is already configured... Starting MariaDB"
	/usr/bin/mysqld
else
	if [ ! -d "/var/lib/mysql/mysql" ]; then
  		mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=root --rpm --skip-test-db > /dev/null
	fi
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
	/usr/bin/mysqld --user=root --datadir=/var/lib/mysql --bootstrap

	# If setup is successful, create a hidden file to mark setuping as completed
	touch /var/lib/mysql/.setup_done

fi

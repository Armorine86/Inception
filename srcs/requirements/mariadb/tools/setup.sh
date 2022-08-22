FILE=/home/mmondell/data/mariadb/.success

if [ ! -f "$FILE" ]; then
	echo "SETUPING DATABASE"
	mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

	mysqld --user=mysql --datadir=/var/lib/mysql &
	sleep 5

	mysql -e "CREATE DATABASE IF NOT EXISTS ${WP_DATABASE};"

	echo "CREATED DATABASE"

	mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_USER_PWD}';"

	echo "CREATED USER"

	mysql -e "GRANT ALL PRIVILEGES ON \`${WP_DATABASE}\`.* TO \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_USER_PWD}';"

	echo "PRIVILEGES GRANTED"

	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PWD}';"

	echo "ROOT PASSWORD SET"

	mysql -u root -p${DB_ROOT_PWD} -e "FLUSH PRIVILEGES;"

	echo "PRIVILEGES FLUSHED"

	touch $FILE
	pkill mysqld

	exec $@
else
	echo "DATABASE ALREADY SET UP"
	exec $@
fi

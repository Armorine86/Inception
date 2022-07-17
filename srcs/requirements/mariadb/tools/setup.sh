mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

mysqld --user=mysql --datadir=/var/lib/mysql &
sleep 5

mysql -e "CREATE DATABASE ${WP_DATABASE};"

echo "CREATED DATABASE"
sleep 1

mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_USER_PWD}';"

echo "CREATED USER"
sleep 1

mysql -e "GRANT ALL PRIVILEGES ON \`${WP_DATABASE}\`.* TO \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_USER_PWD}';"

echo "PRIVILEGES GRANTED"
sleep 1

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PWD}';"

echo "ROOT PASSWORD SET"
sleep 1

mysql -u root -p${DB_ROOT_PWD} -e "FLUSH PRIVILEGES;"

echo "PRIVILEGES FLUSHED"
pkill mysqld

exec $@

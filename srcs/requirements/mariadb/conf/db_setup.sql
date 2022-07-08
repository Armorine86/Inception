-- Creates a database if one of the same name doesn't already exists
CREATE DATABASE IF NOT EXISTS ${MARIA_WORDPRESS_DB} CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Creates a new user
CREATE USER IF NOT EXISTS ${MARIA_DB_USER}@'%' IDENTIFIED BY '${MARIA_DB_USER_PWD}';

-- Grant all privilege on the new database to the new user
GRANT ALL PRIVILEGES ON ${MARIA_WORDPRESS_DB}.* TO ${MARIA_DB_USER} IDENTIFIED BY '${MARIA_DB_USER_PWD}';

-- Resets database root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIA_DB_NEW_ROOT_PWD}';

-- Force grant table to be updated
FLUSH PRIVILEGES;

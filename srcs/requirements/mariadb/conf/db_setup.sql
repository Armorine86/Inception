-- Creates a database if one of the same name doesn't already exists
CREATE DATABASE IF NOT EXISTS ${WP_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Creates a new user
CREATE USER IF NOT EXISTS ${DB_USER_PWD}@'%' IDENTIFIED BY '${DB_USER_PWD}';

-- Grant all privilege on the new database to the new user
GRANT ALL PRIVILEGES ON ${WP_DATABASE}.* TO ${DB_USER_PWD} IDENTIFIED BY '${DB_USER_PWD}';

-- Resets database root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PWD}';

-- Force grant table to be updated
FLUSH PRIVILEGES;

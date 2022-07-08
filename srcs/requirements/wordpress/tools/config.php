<?php

	define("DB_NAME", getenv("MARIA_WORDPRESS_DB"));
	define("DB_USER", getenv("MARIA_DB_USER"));
	define("DB_PASSWORD", getenv("MARIA_DB_USER_PWD"));
	define("DB_HOST", getenv("DB_SERVER") . ":3306");
	define("DB_CHARSET", "utf8");
	define("DB_COLLATE", "utf8_general_ci");
	define('AUTH_KEY', '4242');
	define('SECURE_AUTH_KEY', '4242');
	define('LOGGED_IN_KEY', '4242');
	define('NONCE_KEY', '4242');
	define('AUTH_SALT', '4242');
	define('SECURE_AUTH_SALT', '4242');
	define('LOGGED_IN_SALT', '4242');
	define('NONCE_SALT', '4242');
	define("CONCATENATE_SCRIPTS",	false);

	$table_prefix ="wp_";

	define("WP_DEBUG", true);
	if (!defined("ABSPATH"))
		define("ABSPATH", __DIR__ . "/");

	require_once ABSPATH . "wp-settings.php";
?>

#!/usr/bin/env bash

PHP_CONFIG="/usr/local/etc/php/conf.d/typo3.ini"
APACHE_CONFIG="/etc/apache2/apache2.conf"

# Set LogLevel
sed -i "s/^LogLevel .*/LogLevel ${LOG_LEVEL}/g" $APACHE_CONFIG

# Modify php settings
sed -i "s/^memory_limit = .*/memory_limit = ${PHP_MEMORY_LIMIT}/g" $PHP_CONFIG
sed -i "s|^date.timezone = .*|date.timezone = \"${TZ}\"|g" $PHP_CONFIG
sed -i "s/^max_execution_time = .*/max_execution_time = ${PHP_MAX_EXECUTION_TIME}/g" $PHP_CONFIG
sed -i "s/^upload_max_filesize = .*/upload_max_filesize = ${PHP_MAX_UPLOAD_FILESIZE}/g" $PHP_CONFIG
sed -i "s/^post_max_size = .*/post_max_size = ${PHP_MAX_POST_SIZE}/g" $PHP_CONFIG

#!/usr/bin/env bash

# Adjust permissions
for dir in fileadmin typo3conf typo3temp uploads;
do
  chown -R www-data:www-data "${WEB_ROOT:-/var/www/html}"/${dir}
done

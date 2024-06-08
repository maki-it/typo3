#!/usr/bin/env bash

# Remove empty lines in file
sed -iE '/^$/d' "${WEB_ROOT}"/typo3conf/system/additional.php

# Adjust permissions
for dir in fileadmin typo3conf typo3temp uploads;
do
  chown -R www-data:www-data "${WEB_ROOT:-/var/www/html}"/${dir}
done

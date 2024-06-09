#!/usr/bin/env bash

# Remove empty lines in file
sed -i -E '/^$/d' "${WEB_ROOT}"/typo3conf/system/additional.php

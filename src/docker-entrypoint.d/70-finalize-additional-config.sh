#!/usr/bin/env bash

# Remove empty lines in file
sed -i -E '/^$/d' "${WEB_ROOT}"/typo3conf/system/additional.php

# Mark as first install if not initialized yet
INIT_FLAG_FILE="${WEB_ROOT}"/typo3conf/.initialized
[ ! -f "$INIT_FLAG_FILE" ] && touch "${WEB_ROOT}"/FIRST_INSTALL
touch "$INIT_FLAG_FILE"

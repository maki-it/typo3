#!/usr/bin/env bash

# Typo3 General Configuration
# https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Typo3ConfVars/SYS.html

# Build enabled locale

sed -i "s/^# *\(${LOCALE}.UTF-8\)/\1/" /etc/locale.gen
locale-gen

mkdir -p "${WEB_ROOT}"/typo3conf/system/

echo "<?php
\$GLOBALS['TYPO3_CONF_VARS']['SYS']['systemLocale'] = '${LOCALE}.UTF-8';
\$GLOBALS['TYPO3_CONF_VARS']['SYS']['UTF8filesystem'] = true;
" > "${WEB_ROOT}"/typo3conf/system/additional.php

#!/usr/bin/env bash

if [ "$DATABASE_DRIVER" != "" ]; then
  # Configure Typo3 Database Connection

  echo "Using pre-configured database connection"

  if [ "$DATABASE_DRIVER" == "pdo_sqlite" ]; then
    echo "
\$GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['driver'] = '$DATABASE_DRIVER';
\$GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['path'] = '$DATABASE_SQLITE_PATH';
  " >> "${WEB_ROOT}"/typo3conf/system/additional.php

  else
    echo "
\$GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['charset'] = '$DATABASE_CHARSET';
\$GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['dbname'] = '$DATABASE_NAME';
\$GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['driver'] = '$DATABASE_DRIVER';
\$GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['host'] = '$DATABASE_HOST';
\$GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['port'] = '$DATABASE_PORT';
\$GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['password'] = '$DATABASE_PASSWORD';
\$GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['user'] = '$DATABASE_USERNAME';
\$GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['path'] = '$DATABASE_SQLITE_PATH';
" >> "${WEB_ROOT}"/typo3conf/system/additional.php

  fi
fi
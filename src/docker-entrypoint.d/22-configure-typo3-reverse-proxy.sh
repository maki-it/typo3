#!/usr/bin/env bash

if [ "$ENABLE_REVERSE_PROXY" = "true" ]; then
  # Configure Typo3 for usage with reverse proxy
  echo "
\$GLOBALS['TYPO3_CONF_VARS']['SYS']['reverseProxySSL'] = '*';
\$GLOBALS['TYPO3_CONF_VARS']['SYS']['reverseProxyIP'] = '*';
\$GLOBALS['TYPO3_CONF_VARS']['SYS']['trustedHostsPattern'] = '$DOMAIN';
\$GLOBALS['TYPO3_CONF_VARS']['SYS']['reverseProxyHeaderMultiValue'] = 'first';
" >> "${WEB_ROOT}"/typo3conf/system/additional.php
fi

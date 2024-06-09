#!/usr/bin/env bash

if [ "$REVERSE_PROXY_ENABLE" = "true" ]; then
  # Configure Typo3 for usage with reverse proxy
echo "
\$GLOBALS['TYPO3_CONF_VARS']['SYS']['reverseProxySSL'] = '$REVERSE_PROXY_SSL';
\$GLOBALS['TYPO3_CONF_VARS']['SYS']['reverseProxyIP'] = '$REVERSE_PROXY_IPS';
\$GLOBALS['TYPO3_CONF_VARS']['SYS']['trustedHostsPattern'] = '$REVERSE_PROXY_TRUSTED_HOSTS_PATTERN';
\$GLOBALS['TYPO3_CONF_VARS']['SYS']['reverseProxyHeaderMultiValue'] = '$REVERSE_PROXY_HEADER_MULTI_VALUE';
" >> "${WEB_ROOT}"/typo3conf/system/additional.php

fi

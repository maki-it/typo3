#!/usr/bin/env bash

# Typo3 Configuration for Mail/SMTP
# https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Typo3ConfVars/MAIL.html#typo3ConfVars_mail

echo "
\$GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport_smtp_server'] = '${MAIL_SMTP_SERVER}:${MAIL_SMTP_PORT}';
\$GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport_smtp_domain'] = '${MAIL_SMTP_DOMAIN}';
\$GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport_smtp_encrypt'] = '${MAIL_SMTP_ENCRYPTION}';
\$GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport_smtp_username'] = '${MAIL_SMTP_USERNAME}';
\$GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport_smtp_password'] = '${MAIL_SMTP_PASSWORD}';
\$GLOBALS['TYPO3_CONF_VARS']['MAIL']['defaultMailFromAddress'] = '${MAIL_SMTP_DEFAULT_FROM_ADDRESS}';
\$GLOBALS['TYPO3_CONF_VARS']['MAIL']['defaultMailFromName'] = '${MAIL_SMTP_DEFAULT_FROM_NAME}';
\$GLOBALS['TYPO3_CONF_VARS']['MAIL']['defaultMailReplyToAddress'] = '${MAIL_SMTP_DEFAULT_REPLY_ADDRESS}';
\$GLOBALS['TYPO3_CONF_VARS']['MAIL']['defaultMailReplyToName'] = '${MAIL_SMTP_DEFAULT_REPLY_NAME}';
" >> "${WEB_ROOT}"/typo3conf/system/additional.php

# Typo3 containerized

A Typo3 Image for Container and Cloud Environments.

## Environment variables

### General

- `TZ`: Default: `UTC` Timezone inside the container, e.g. "Europe/Berlin"
- `DOMAIN`: Default `-` Domain name of the Website, e.g. "domain.com"
- `ENABLE_REVERSE_PROXY`: Default: `false` Enable to access the website behind a reverse proxy
- `LOCALE`: Default: `en_US` Set UTF-8 compatible locale information
- `LOG_LEVEL`: Default: `warn` [Log level](#log-levels) of the Apache web server

### PHP

- `PHP_MEMORY_LIMIT`: Default `256M` Maximum memory available to PHP
- `PHP_MAX_EXECUTION_TIME`: Default `240` Maximum execution time for PHP scripts
- `PHP_MAX_UPLOAD_FILESIZE`: Default `32M` Maximum size of a single file to upload
- `PHP_MAX_POST_SIZE` Default `32M` Maximum Post size

### Mail/SMTP

Also see **[transport_smtp_*](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Typo3ConfVars/MAIL.html#confval-globals-typo3-conf-vars-mail-transport-smtp)** in the Typo 3 docs

- `MAIL_SMTP_ENCRYPTION`: Default `false` Whether to use STARTTLS if possible (default/false) or SSL/TLS (true).
  See [transport_smtp_encrypt](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Typo3ConfVars/MAIL.html#confval-globals-typo3-conf-vars-mail-transport-smtp-encrypt)
- `MAIL_SMTP_USERNAME`: Default `-` If your SMTP server requires authentication, enter your username here.
- `MAIL_SMTP_PASSWORD`: Default `-` If your SMTP server requires authentication, enter your password here.
- `MAIL_SMTP_DOMAIN`: Default `-` Use if your smtp-relay-server requires the domain to be set from which the sender is
  sending an
  email. [More info in the docs](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Typo3ConfVars/MAIL.html#confval-globals-typo3-conf-vars-mail-transport-smtp-domain).
- `MAIL_SMTP_SERVER`: Default `-` Server of the mail server to connect to.
- `MAIL_SMTP_PORT`: Default `25` Port of the mail server to connect to.
- `MAIL_SMTP_DEFAULT_FROM_ADDRESS`: Default `-` This default email address is used when no other "from" address is set
  for a TYPO3-generated email. You can only specify an email address (for example 'info@example.org').
- `MAIL_SMTP_DEFAULT_FROM_NAME`: Default `-` This default name is used when no other "from" name is set for a
  TYPO3-generated email.
- `MAIL_SMTP_DEFAULT_REPLY_ADDRESS`: Default `-` This default email address is used when no other "reply-to" address is
  set for a TYPO3-generated email. You can only specify an email address (for example 'info@example.org').
- `MAIL_SMTP_DEFAULT_REPLY_NAME`: Default `-` This default name is used when no other "reply-to" name is set for a
  TYPO3-generated email.

## Log levels

A log level only outputs logs of the current level and above.  
E.g. The default level `warn` does output messages for warning, error and above but not notice, info or below.

| Level  | Description                        |
|--------|------------------------------------|
| emerg  | System is unusable                 |
| alert  | Action must be taken immediately   |
| crit   | Critical conditions                |
| error  | Error conditions                   |
| warn   | Warning conditions                 |
| notice | Normal, but significant conditions |
| info   | Informational messages             |
| debug  | Debugging messages                 |

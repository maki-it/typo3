# Typo3 containerized

A Typo3 Image for Container and Cloud Environments.

## Environment variables

### General

- `TZ`: Default: `UTC` Timezone inside the container, e.g. "Europe/Berlin"
- `DOMAIN`: Default `-` Domain name of the Website, e.g. "domain.com"
- `LOCALE`: Default: `en_US` Set a UTF-8 compatible localisation
- `LOG_LEVEL`: Default: `warn` [Log level](#log-levels) of the Apache web server

### PHP

- `PHP_MEMORY_LIMIT`: Default `256M` Maximum memory available to PHP
- `PHP_MAX_EXECUTION_TIME`: Default `240` Maximum execution time for PHP scripts
- `PHP_MAX_UPLOAD_FILESIZE`: Default `32M` Maximum size of a single file to upload
- `PHP_MAX_POST_SIZE` Default `32M` Maximum Post size

### Reverse Proxy

- `REVERSE_PROXY_ENABLE`: Default: `false` Enable to access the website behind a reverse proxy
- `REVERSE_PROXY_SSL`: Default: `*` '*' (wildcard) or list of IP addresses of proxies that use SSL (https) for the connection to the client, but an unencrypted connection (http) to the server. See the [docs](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Typo3ConfVars/SYS.html#confval-globals-typo3-conf-vars-sys-reverseproxyssl)
- `REVERSE_PROXY_IPS`: Default: `*` List of IP addresses or '*' (wildcard). If TYPO3 is behind one or more (intransparent) reverse proxies the IP addresses must be added here. See the [docs](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Typo3ConfVars/SYS.html#confval-globals-typo3-conf-vars-sys-reverseproxyip)
- `REVERSE_PROXY_HEADER_MULTI_VALUE`: Default: `first` Defines which values of a proxy header (for example HTTP_X_FORWARDED_FOR) to use, if more than one is found. See the [docs](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Typo3ConfVars/SYS.html#confval-globals-typo3-conf-vars-sys-reverseproxyheadermultivalue)
- `REVERSE_PROXY_TRUSTED_HOSTS_PATTERN`: Default: `SERVER_NAME` Regular expression pattern that matches all allowed hostnames (including their ports) of this TYPO3 installation, or the string SERVER_NAME (default). See the [docs](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Typo3ConfVars/SYS.html#confval-globals-typo3-conf-vars-sys-trustedhostspattern)

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

### Automated Typo3 Setup

If you want to let Typo3 set up itself automatically via environment variables

- `TYPO3_AUTO_SETUP_ENABLE`: Default: `false` Enable the automated setup
- `TYPO3_PROJECT_NAME`: Default: `New TYPO3 Project` Name of the Typo3 Site
- `TYPO3_SETUP_CREATE_SITE`: Default: `false` Create a basic site setup (root page and site configuration) with the given domain, e.g. "https://your-typo3-site.com/"

#### Administrator User

- `TYPO3_SETUP_ADMIN_USERNAME`: Username of the initial/first administrator user
- `TYPO3_SETUP_ADMIN_PASSWORD`: Password of the initial/first administrator user
- `TYPO3_SETUP_ADMIN_EMAIL`: Email Address of the initial/first administrator user

#### Database Connection

- `TYPO3_DB_DRIVER`: The built-in driver implementation to use. The following drivers are currently available:
  - `mysqli`: A MySQL/MariaDB driver that uses the mysqli extension.
  - `pdoMysql`: A MySQL/MariaDB driver that uses the pdo_mysql PDO extension.
  - `postgres`: A PostgreSQL driver that uses the pdo_pgsql PDO extension.
  - `sqlite`: An SQLite driver that uses the pdo_sqlite PDO extension.
- `TYPO3_DB_DBNAME`: Name of the database/schema to connect to. Can be used with MySQL/MariaDB and PostgreSQL.
- `TYPO3_DB_HOST`: Hostname or IP address of the database to connect to. Can be used with MySQL/MariaDB and PostgreSQL.
- `TYPO3_DB_PORT`: Port of the database to connect to. Can be used with MySQL/MariaDB and PostgreSQL.
- `TYPO3_DB_USERNAME`: Username to use when connecting to the database.
- `TYPO3_DB_PASSWORD`: Password to use when connecting to the database.

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

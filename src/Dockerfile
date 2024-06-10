FROM php:8.3-apache-bookworm as base

LABEL maintainer="Maki IT <kontakt@maki-it.de>"

# renovate: datasource=github-tags depName=typo3 packageName=TYPO3/typo3
ARG TYPO3_VERSION=12.4.15
# renovate: datasource=github-releases depName=typo3-console packageName=TYPO3-Console/TYPO3-Console
ARG TYPO3_CONSOLE_VERSION=8.1.1
ARG WEB_ROOT='/var/www/html'

ENV TZ=UTC \
    LOG_LEVEL=warn \
    WEB_ROOT=$WEB_ROOT \
    LOCALE='en_US' \
    TYPO3_AUTO_SETUP_ENABLE=false \
    TYPO3_SETUP_CREATE_SITE='' \
    # Reverse Proxy
    REVERSE_PROXY_ENABLE=false \
    REVERSE_PROXY_SSL='*' \
    REVERSE_PROXY_IPS='*' \
    REVERSE_PROXY_HEADER_MULTI_VALUE='first' \
    REVERSE_PROXY_TRUSTED_HOSTS_PATTERN='SERVER_NAME' \
    # PHP
    PHP_MEMORY_LIMIT=256M \
    PHP_MAX_EXECUTION_TIME=240 \
    PHP_MAX_UPLOAD_FILESIZE=32M \
    PHP_MAX_POST_SIZE=32M \
    # Mail/SMTP
    MAIL_SMTP_DEFAULT_FROM_ADDRESS='' \
    MAIL_SMTP_DEFAULT_FROM_NAME='' \
    MAIL_SMTP_DEFAULT_REPLY_ADDRESS='' \
    MAIL_SMTP_DEFAULT_REPLY_NAME='' \
    MAIL_SMTP_ENCRYPTION=false \
    MAIL_SMTP_USERNAME='' \
    MAIL_SMTP_PASSWORD='' \
    MAIL_SMTP_DOMAIN='' \
    MAIL_SMTP_SERVER='localhost' \
    MAIL_SMTP_PORT=25

WORKDIR $WEB_ROOT

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    # Configure PHP
        libxml2-dev libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libpq-dev \
        libzip-dev \
        zlib1g-dev \
    # Install required 3rd party tools
        graphicsmagick ghostscript locales unzip && \
    sed -i "s/^# *\(${LOCALE}.UTF-8\)/\1/" /etc/locale.gen && \
    locale-gen && \
    # Configure extensions \
    pecl install redis && \
    docker-php-ext-configure gd --with-libdir=/usr/include/ --with-jpeg --with-freetype && \
    docker-php-ext-install -j$(nproc) soap gd zip opcache intl pgsql pdo pdo_pgsql pdo_mysql mysqli exif && \
    docker-php-ext-enable redis && \
    # Configure Apache as needed
    a2enmod rewrite && \
    apt-get clean && \
    apt-get -y purge \
        libxml2-dev libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libzip-dev \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

ADD https://get.typo3.org/${TYPO3_VERSION}/tar.gz typo3_src-${TYPO3_VERSION}

COPY configs/php.ini /usr/local/etc/php/conf.d/typo3.ini
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY docker-entrypoint.d /docker-entrypoint.d
COPY scripts/typo3 /usr/bin/typo3

# Copy composer binary to this image
#COPY --from=composer/composer:latest-bin /composer /usr/local/bin/composer

# Install TYPO3
RUN tar -xzf typo3_src-${TYPO3_VERSION} && \
    ln -s typo3_src-* typo3_src && \
    ln -s typo3_src/index.php && \
    ln -s typo3_src/typo3 && \
    cp typo3/sysext/install/Resources/Private/FolderStructureTemplateFiles/root-htaccess .htaccess && \
    mkdir typo3temp && \
    mkdir typo3conf && \
    mkdir fileadmin && \
    mkdir uploads && \
    chown -R www-data: $WEB_ROOT && \
    chmod +x /docker-entrypoint.sh /usr/local/bin/docker-php-entrypoint && \
    chmod +x /bin/typo3 && \
    curl -o typo3_console.zip "https://extensions.typo3.org/extension/download/typo3_console/${TYPO3_CONSOLE_VERSION}/zip/" && \
    mkdir -p ${WEB_ROOT}/typo3conf/ext/ && \
    unzip typo3_console.zip -d ${WEB_ROOT}/typo3conf/ext/typo3_console/ && \
    rm typo3_console.zip && \
    php typo3conf/ext/typo3_console/activate


VOLUME ${WEB_ROOT}/fileadmin
VOLUME ${WEB_ROOT}/typo3conf
VOLUME ${WEB_ROOT}/typo3temp
VOLUME ${WEB_ROOT}/uploads

EXPOSE 80

# https://httpd.apache.org/docs/2.4/stopping.html#gracefulstop
STOPSIGNAL SIGWINCH

ENTRYPOINT ["bash", "/docker-entrypoint.sh"]
CMD ["apache2-foreground"]
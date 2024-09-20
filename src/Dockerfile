FROM php:8.3-apache-bookworm as base

LABEL maintainer="Maki IT <kontakt@maki-it.de>"

# renovate: datasource=github-tags depName=typo3 packageName=TYPO3/typo3
ARG TYPO3_VERSION=13.3.0
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

# Configure PHP
RUN savedAptMark="$(apt-mark showmanual)" && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        libfreetype6-dev \
        libtool \
        libxml2-dev \
        libjpeg-dev \
        libmcrypt-dev \
        libpng-dev \
        libpq-dev \
        libicu-dev \
        libyaml-dev \
        libzip-dev \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/* && \
    export CFLAGS="$PHP_CFLAGS" CPPFLAGS="$PHP_CPPFLAGS" LDFLAGS="$PHP_LDFLAGS" && \
    pecl install apcu yaml && \
    docker-php-ext-configure intl --enable-intl && \
    docker-php-ext-configure gd --with-libdir=/usr/include/ --with-jpeg --with-freetype && \
    docker-php-ext-install -j$(nproc) soap gd zip opcache intl pgsql pdo pdo_pgsql pdo_mysql mysqli exif && \
    docker-php-ext-enable apcu yaml && \
    apt-get clean && \
    apt-mark auto '.*' > /dev/null && \
    apt-mark manual $savedAptMark && \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $PHPIZE_DEPS && \
    #mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" && \
    rm -rf /usr/src/php.tar.xz*

# Install required 3rd party tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        imagemagick \
        ghostscript \
        locales  \
        unzip \
        supervisor \
        libzip4 \
        libyaml-0-2 \
        cron && \
    rm -rf /var/lib/apt/lists/* && \
    sed -i "s/^# *\(${LOCALE}.UTF-8\)/\1/" /etc/locale.gen && \
    locale-gen

RUN a2enmod rewrite expires headers

# Add recommended opcache settings from https://secure.php.net/manual/en/opcache.installation.php
COPY configs/opcache-recommended.ini /usr/local/etc/php/conf.d/opcache-recommended.ini
COPY configs/typo3-php.ini /usr/local/etc/php/conf.d/typo3.ini
COPY configs/supervisord.conf /etc/supervisor/supervisord.conf
COPY configs/apache-typo3-site.conf /etc/apache2/sites-available/typo3.conf

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY docker-entrypoint.d /docker-entrypoint.d
COPY scripts/typo3 /usr/bin/typo3

ADD https://get.typo3.org/${TYPO3_VERSION}/tar.gz typo3_src-${TYPO3_VERSION}

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
    php typo3conf/ext/typo3_console/activate && \
    echo "*/5 * * * * /usr/local/bin/php ${WEB_ROOT}/typo3/sysext/core/bin/typo3 scheduler:run" > /var/spool/cron/crontabs/www-data && \
    chmod 600 /var/spool/cron/crontabs/www-data && \
    sed -i "s|DocumentRoot .*|DocumentRoot ${WEB_ROOT}|g" /etc/apache2/sites-available/typo3.conf && \
    ln -s /etc/apache2/sites-available/typo3.conf /etc/apache2/sites-enabled/typo3.conf && \
    unlink /etc/apache2/sites-enabled/000-default.conf


VOLUME ${WEB_ROOT}/fileadmin
VOLUME ${WEB_ROOT}/typo3conf
VOLUME ${WEB_ROOT}/typo3temp
VOLUME ${WEB_ROOT}/uploads

EXPOSE 80

# https://httpd.apache.org/docs/2.4/stopping.html#gracefulstop
STOPSIGNAL SIGWINCH

ENTRYPOINT ["bash", "/docker-entrypoint.sh"]
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]

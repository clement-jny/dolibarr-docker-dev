FROM php:8.2-apache


# Install minimal required packages for Dolibarr
RUN apt-get update && apt-get install -y \
    # imagemagick \
    # libc-client-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmagickwand-dev --no-install-recommends \
    libpng-dev \
    libkrb5-dev \
    libxml2-dev \
    libzip-dev \
    libicu-dev \
    --no-install-recommends \
# Enable Apache mod_rewrite
    && a2enmod rewrite \
# Configure and install core PHP extensions required by Dolibarr
    && docker-php-ext-install exif \
        calendar \
        intl \
        zip \
        mysqli \
        pdo \
        pdo_mysql \
# Configure and install GD
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
# Install Imagick and Xdebug
    # && pecl install imagick xdebug \
    # && docker-php-ext-enable imagick xdebug
# Clean up build dependencies
    && apt-get purge -y --auto-remove \
    && apt-get clean \
    && rm -rf /tmp/pear \
    && rm -rf /var/lib/apt/lists/*

# Configure PHP for Dolibarr
RUN { \
    # echo 'memory_limit = 256M'; \
    echo 'upload_max_filesize = 50M'; \
    echo 'post_max_size = 50M'; \
    echo 'max_execution_time = 300'; \
    echo 'date.timezone = Europe/Paris'; \
} > /usr/local/etc/php/conf.d/dolibarr.ini


# Set working directory
WORKDIR /var/www/html

# Expose port 80
EXPOSE 80


# # # Configure and install IMAP
# # RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
# #     docker-php-ext-install imap
# # # Installation de l'extension IMAP via PECL (libc-client n'est plus dans Debian Trixie)
# # # RUN pecl install imap && docker-php-ext-enable imap
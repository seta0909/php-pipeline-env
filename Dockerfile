FROM ubuntu:16.04

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y software-properties-common python-software-properties
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
# Install dependencies
RUN apt-get update && apt-get install -yq --no-install-recommends \
    apt-utils \
    curl \
    # Install git
    git \
    # Install apache
    nginx \
    # Install php 7.2
    php7.2-dev \
    php7.2-cli \
    php7.2-json \
    php7.2-curl \
    php7.2-fpm \
    php7.2-gd \
    php7.2-ldap \
    php7.2-mbstring \
    php7.2-mysql \
    php7.2-xml \
    php7.2-zip \
    php7.2-intl \
    php7.2-exif \
    php7.2-redis \
    php-imagick \
    php-pear \
    # Install tools
    openssl \
    nano \
    graphicsmagick \
    imagemagick \
    ghostscript \
    mysql-client \
    iputils-ping \
    nodejs \
    npm \
    locales \
    vim \
    supervisor \
    libhiredis-dev \
    gcc \
    make \
    musl-dev \
    re2c \
    wget \
    autoconf \
    automake \
    libtool \
    g++ \
    libz-dev \
    #install wkhtmltopdf language font
    fonts-wqy-microhei \
    ttf-wqy-microhei \
    fonts-wqy-zenhei \
    ttf-wqy-zenhei \
    redis-tools \
    jpegoptim \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/nrk/phpiredis.git && \
    cd phpiredis && \
    phpize && \
    ./configure --enable-phpiredis && \
    make && \
    make install

# Install grpc
RUN pecl config-set php_ini "${PHP_INI_DIR}/php.ini"
RUN pecl install grpc-1.12.0
RUN echo 'extension=grpc.so' >> /etc/php/7.2/cli/php.ini
RUN echo 'extension=grpc.so' >> /etc/php/7.2/fpm/php.ini

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

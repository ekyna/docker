FROM php:5.6.30-fpm

MAINTAINER Etienne Dauvergne <contact@ekyna.com>

RUN echo \
"deb http://http.debian.net/debian jessie main contrib\n\
deb-src http://http.debian.net/debian jessie main contrib\n\
deb http://security.debian.org/ jessie/updates main contrib\n\
deb-src http://security.debian.org/ jessie/updates main contrib\n\
" > /etc/apt/sources.list

# Install utilies
RUN apt-get update \
 && apt-get install -y --force-yes \
    curl \
    git \
    unzip \
    xvfb \
    xauth \
    openjdk-7-jre \
    nodejs \
    npm \
    ttf-freefont \
    libicu-dev \
    libmcrypt-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng12-dev \
    libvpx-dev \
    libxpm-dev \
    libxml2-dev \
    libssl-dev \
    zlib1g-dev \
    fontconfig \
    dbus \
    jpegoptim \
    wkhtmltopdf \
    --no-install-recommends \
 && docker-php-ext-configure gd \
    --enable-gd-native-ttf \
    --with-freetype-dir=/usr/include/freetype2/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
    --with-xpm-dir=/usr/include/ \
    --with-vpx-dir=/usr/include/ \
 && docker-php-ext-install \
    bcmath \
    opcache \
    intl \
    mysqli \
    pdo_mysql \
    zip \
    gd \
    mcrypt \
    exif \
    soap \
 && pecl install apcu-4.0.11 && docker-php-ext-enable apcu \
 && git config --global credential.helper cache \
 && mv /usr/bin/wkhtmltopdf /usr/bin/wkhtmltopdf-origin \
 && echo "#!/bin/bash \n\
/usr/bin/xvfb-run -a -s \"-screen 0 1280x1024x16\" /usr/bin/wkhtmltopdf-origin \$@ \n\
" > /usr/bin/wkhtmltopdf && \
    chmod +x /usr/bin/wkhtmltopdf \
 && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php --version=1.10.20 --quiet --install-dir=/usr/local/bin --filename=composer \
 && php -r "unlink('composer-setup.php');" \
 && apt-get autoremove -y \
 && apt-get clean all \
 && rm -r /var/lib/apt/lists/*

WORKDIR /var/www


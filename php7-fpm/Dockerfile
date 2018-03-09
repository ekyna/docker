FROM alpine:3.7
MAINTAINER Etienne Dauvergne <contact@ekyna.com>

ENV PHP_VERSION="7.1.15-r0"

COPY config /tmp/config

RUN apk add \
# Install utilies
      mailcap \
      file \
      bash \
      sed \
      grep \
      curl \
      unzip \
      git \
      jpegoptim \
      dcron \
      imagemagick \
# Install php
      php7=$PHP_VERSION \
      php7-dom=$PHP_VERSION \
      php7-ctype=$PHP_VERSION \
      php7-curl=$PHP_VERSION \
      php7-fpm=$PHP_VERSION \
      php7-fileinfo=$PHP_VERSION \
      php7-session=$PHP_VERSION \
      php7-tokenizer=$PHP_VERSION \
      php7-sockets=$PHP_VERSION \
      php7-simplexml=$PHP_VERSION \
      php7-ctype=$PHP_VERSION \
      php7-gd=$PHP_VERSION \
      php7-intl=$PHP_VERSION \
      php7-json=$PHP_VERSION \
      php7-mbstring=$PHP_VERSION \
      php7-mcrypt=$PHP_VERSION \
      php7-mysqlnd=$PHP_VERSION \
      php7-opcache=$PHP_VERSION \
      php7-pdo=$PHP_VERSION \
      php7-pdo_mysql=$PHP_VERSION \
      php7-posix=$PHP_VERSION \
      php7-session=$PHP_VERSION \
      php7-xml=$PHP_VERSION \
      php7-xmlreader=$PHP_VERSION \
      php7-xmlwriter=$PHP_VERSION \
      php7-xsl=$PHP_VERSION \
      php7-iconv=$PHP_VERSION \
      php7-phar=$PHP_VERSION \
      php7-openssl=$PHP_VERSION \
      php7-bcmath=$PHP_VERSION \
      php7-exif=$PHP_VERSION \
      php7-soap=$PHP_VERSION \
      php7-ftp=$PHP_VERSION \
      php7-zip=$PHP_VERSION \
      php7-zlib=$PHP_VERSION \
      php7-oauth=2.0.2-r1 \
      php7-redis=3.1.4-r0 \
      php7-apcu=5.1.8-r1 \
      php7-imagick=3.4.3-r3 \
# For WkHtmlToPdf
      xvfb \
      ttf-freefont \
      fontconfig \
      dbus \
      --update --no-cache \
# WkHtmlToPdf (testing repository)
 && apk add \
      wkhtmltopdf=0.12.4-r0 \
      --update --no-cache \
      --allow-untrusted --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
# Cleanup
 && rm -rf /var/cache/apk/* \
# XVFB wrapper for wkhtmltopdf
 && mv /usr/bin/wkhtmltopdf /usr/bin/wkhtmltopdf-origin \
 && echo $'#!/usr/bin/env sh\nXvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset & \nDISPLAY=:0.0 wkhtmltopdf-origin $@ \nkillall Xvfb' > /usr/bin/wkhtmltopdf \
 && chmod +x /usr/bin/wkhtmltopdf \
# XVFB wrapper for wkhtmltoimage
 && mv /usr/bin/wkhtmltoimage /usr/bin/wkhtmltoimage-origin \
 && echo $'#!/usr/bin/env sh\nXvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset & \nDISPLAY=:0.0 wkhtmltoimage-origin $@ \nkillall Xvfb' > /usr/bin/wkhtmltoimage \
 && chmod +x /usr/bin/wkhtmltoimage \
# Configure PHP
#  && ln -s /usr/bin/php7 /usr/bin/php
 && mv -f /tmp/config/php.ini /etc/php7/conf.d/50-settings.ini \
 && mv -f /tmp/config/php-fpm.conf /etc/php7/php-fpm.conf \
 && rm -Rf /tmp/config \
#  && chmod 0700 /etc/php7/conf.d/50-settings.ini
#  && chmod 0700 /etc/php7/php-fpm.conf
# Install composer
 && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php -r "if (trim(hash_file('SHA384', 'composer-setup.php')) !== trim(file_get_contents('https://composer.github.io/installer.sig'))) { echo 'Composer installer corrupt' . PHP_EOL; exit(1); }" \
 && php composer-setup.php --quiet --install-dir=/usr/bin --filename=composer \
 && php -r "unlink('composer-setup.php');" \
# Create www-data user
 && addgroup www-data -g 1000 \
 && adduser -D -u 1000 -h /var/www -s /sbin/nologin -G www-data www-data \
 && chown -Rf www-data:www-data /var/www

WORKDIR /var/www

CMD ["php-fpm7", "-F"]

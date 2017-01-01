FROM alpine:edge
MAINTAINER Etienne Dauvergne <contact@ekyna.com>

ENV PHP_VERSION="7.0.14-r5"

COPY config /tmp/config

RUN apk add \
# Install utilies
      bash \
      sed \
      grep \
      git \
# Install php
      php7=$PHP_VERSION \
      php7-dom=$PHP_VERSION \
      php7-ctype=$PHP_VERSION \
      php7-curl=$PHP_VERSION \
      php7-fpm=$PHP_VERSION \
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
      php7-iconv=$PHP_VERSION \
      php7-phar=$PHP_VERSION \
      php7-openssl=$PHP_VERSION \
      php7-bcmath=$PHP_VERSION \
      php7-exif=$PHP_VERSION \
      php7-soap=$PHP_VERSION \
      php7-ftp=$PHP_VERSION \
# For WkHtmlToPdf
      xvfb \
      ttf-freefont \
      fontconfig \
      dbus \

      --update --no-cache \

# JpegOptim WkHtmlToPdf and APC (testing repository)
 && apk add \
      php7-apcu \
      jpegoptim \
      wkhtmltopdf \

      --update --no-cache --allow-untrusted \
      --repository http://alpine.gliderlabs.com/alpine/edge/testing/ \

# Cleanup
  && rm -rf /var/cache/apk/* \

# Configure Git
  && git config --global credential.helper cache \

# Wrapper for xvfb
  && mv /usr/bin/wkhtmltopdf /usr/bin/wkhtmltopdf-origin \
  && echo $'#!/usr/bin/env sh\n\
Xvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset & \n\
DISPLAY=:0.0 wkhtmltopdf-origin $@ \n\
killall Xvfb\
' > /usr/bin/wkhtmltopdf && \
  chmod +x /usr/bin/wkhtmltopdf \

# Configure PHP
  && ln -s /usr/bin/php7 /usr/bin/php \
  && mv -f /tmp/config/php.ini /etc/php7/conf.d/50-settings.ini \
  && mv -f /tmp/config/php-fpm.conf /etc/php7/php-fpm.conf \
#  && chmod 0700 /etc/php7/conf.d/50-settings.ini \
#  && chmod 0700 /etc/php7/php-fpm.conf \

# Install composer
  && php -r "readfile('https://getcomposer.org/installer');" \
     | php -- --install-dir=/usr/local/bin --filename=composer \
  && chmod +x /usr/local/bin/composer \

# Create www-data user
  && addgroup www-data -g 1000 \
  && adduser -D -u 1000 -h /var/www -s /sbin/nologin -G www-data www-data
#  && chown -Rf www-data:www-data /var/www

WORKDIR /var/www

EXPOSE 9000

CMD ["php-fpm7", "-F"]

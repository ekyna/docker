FROM alpine:edge
MAINTAINER Etienne Dauvergne <contact@ekyna.com>

COPY config /tmp/config

RUN apk add \
# Install utilies
      bash \
      sed \
      grep \
      git \
# Install php
      php7 \
      php7-dom \
      php7-ctype \
      php7-curl \
      php7-fpm \
      php7-gd \
      php7-intl \
      php7-json \
      php7-mbstring \
      php7-mcrypt \
      php7-mysqlnd \
      php7-opcache \
      php7-pdo \
      php7-pdo_mysql \
      php7-posix \
      php7-session \
      php7-xml \
      php7-iconv \
      php7-phar \
      php7-openssl \
      php7-bcmath \
      php7-exif \
      php7-soap \
      --update --no-cache \

# JpegOptim and WkHtmlToPdf and APC (testing repository)
 && apk add \
      jpegoptim \
      wkhtmltopdf \
      php7-apcu \
      --update --no-cache --allow-untrusted \
      --repository http://alpine.gliderlabs.com/alpine/edge/testing/ \
# Cleanup
  && rm -rf /var/cache/apk/* \

# Configure Git
  && git config --global credential.helper cache \

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

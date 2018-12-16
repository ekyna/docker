FROM alpine:3.8

MAINTAINER Etienne Dauvergne <contact@ekyna.com>

RUN apk add \
      mailcap \
      file \
      bash \
      sed \
      grep \
      unzip \
      git \
      jpegoptim \
      pngquant \
      dcron \
      imagemagick \
      ffmpeg \
      php7 \
      php7-apcu \
      php7-bcmath \
      php7-ctype \
      php7-curl \
      php7-dom \
      php7-exif \
      php7-fileinfo \
      php7-fpm \
      php7-ftp \
      php7-gd \
      php7-iconv \
      php7-imagick \
      php7-imap \
      php7-intl \
      php7-json \
      php7-mbstring \
      php7-mysqlnd \
      php7-oauth \
      php7-opcache \
      php7-openssl \
      php7-pdo \
      php7-pdo_mysql \
      php7-phar \
      php7-posix \
      php7-redis \
      php7-session \
      php7-simplexml \
      php7-soap \
      php7-sodium \
      php7-sockets \
      php7-tokenizer \
      php7-xml \
      php7-xmlreader \
      php7-xmlwriter \
      php7-xsl \
      php7-zip \
      xvfb \
      ttf-freefont \
      fontconfig \
      dbus \
      libressl2.7-libcrypto \
      --no-cache \
 && apk add \
      wkhtmltopdf \
      --no-cache \
      --allow-untrusted --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
 && rm -rf /var/cache/apk/* \
 && mv /usr/bin/wkhtmltopdf /usr/bin/wkhtmltopdf-origin \
 && echo $'#!/usr/bin/env sh\nXvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset & \nDISPLAY=:0.0 wkhtmltopdf-origin $@ \nkillall Xvfb' > /usr/bin/wkhtmltopdf \
 && chmod +x /usr/bin/wkhtmltopdf \
 && mv /usr/bin/wkhtmltoimage /usr/bin/wkhtmltoimage-origin \
 && echo $'#!/usr/bin/env sh\nXvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset & \nDISPLAY=:0.0 wkhtmltoimage-origin $@ \nkillall Xvfb' > /usr/bin/wkhtmltoimage \
 && chmod +x /usr/bin/wkhtmltoimage \
 && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php -r "if (trim(hash_file('SHA384', 'composer-setup.php')) !== trim(file_get_contents('https://composer.github.io/installer.sig'))) { echo 'Composer installer corrupt' . PHP_EOL; exit(1); }" \
 && php composer-setup.php --quiet --install-dir=/usr/bin --filename=composer \
 && php -r "unlink('composer-setup.php');"

CMD ["php-fpm7", "-F"]

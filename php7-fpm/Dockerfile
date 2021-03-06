FROM alpine:3.12

MAINTAINER Etienne Dauvergne <contact@ekyna.com>

COPY --from=mwader/static-ffmpeg:4.3 /ffmpeg /ffprobe /usr/bin/

RUN apk add \
      tzdata \
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
      rsync \
      imagemagick \
      gettext \
      php7 \
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
      php7-imap \
      php7-intl \
      php7-json \
      php7-gettext \
      php7-mbstring \
      php7-mysqlnd \
      php7-opcache \
      php7-openssl \
      php7-pcntl \
      php7-pdo \
      php7-pdo_mysql \
      php7-pecl-apcu \
      php7-pecl-imagick \
      php7-pecl-oauth \
      php7-pecl-redis \
      php7-phar \
      php7-posix \
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
      --no-cache \
 && rm -rf /var/cache/apk/* \
 && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php -r "if (trim(hash_file('SHA384', 'composer-setup.php')) !== trim(file_get_contents('https://composer.github.io/installer.sig'))) { echo 'Composer installer corrupt' . PHP_EOL; exit(1); }" \
 && php composer-setup.php --quiet --install-dir=/usr/bin --filename=composer \
 && php -r "unlink('composer-setup.php');"

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh \
 && mkdir -p /entrypoint.d

EXPOSE 9000

ENV TZ="Europe/Paris" \
    LANG="C.UTF-8" \
    COMPOSER_MIRROR_PATH_REPOS=1

ENTRYPOINT [ "/entrypoint.sh" ]

CMD ["/usr/sbin/php-fpm7", "-F"]

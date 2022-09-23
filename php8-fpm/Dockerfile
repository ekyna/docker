FROM php:8.1.10-fpm-alpine3.16

MAINTAINER Etienne Dauvergne <contact@ekyna.com>

# Pull these images before build
COPY --from=mwader/static-ffmpeg:latest /ffmpeg /ffprobe /usr/local/bin/
COPY --from=mlocati/php-extension-installer:latest /usr/bin/install-php-extensions /usr/local/bin/

RUN set -eux; \
    apk --no-cache add \
        tzdata \
        bash \
        jpegoptim \
        pngquant \
        icu-data-full; \
    install-php-extensions \
        bcmath \
        decimal \
        exif \
        imap \
        intl \
        gd \
        gettext \
        opcache \
        pcntl \
        pdo_mysql \
        soap \
        sockets \
        ssh2 \
        xsl \
        zip \
        apcu \
        oauth \
        redis \
        amqp; \
    docker-php-source delete; \
    rm /usr/local/bin/install-php-extensions

CMD ["/usr/local/sbin/php-fpm", "-F"]

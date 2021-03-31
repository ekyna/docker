FROM php:7.4.16-fpm-alpine

MAINTAINER Etienne Dauvergne <contact@ekyna.com>

COPY --from=mwader/static-ffmpeg:latest /ffmpeg /ffprobe /usr/local/bin/
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

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
        freetype \
        libjpeg-turbo \
        libpng \
        libwebp \
        libxpm \
        musl \
        --no-cache \
 && rm -rf /var/cache/apk/* \
 && docker-php-ext-configure gd --with-freetype --with-jpeg --with-png --with-xpm --with-webp \
 && docker-php-ext-install -j$(nproc) gd \
 && install-php-extensions \
        @composer \
        bcmath \
        exif \
        imap \
        intl \
        gettext \
        opcache \
        pcntl \
        pdo_mysql \
        soap \
        sockets \
        xsl \
        apcu \
        oauth \
        imagick \
        redis \
 && docker-php-source delete \
 && rm /usr/local/bin/install-php-extensions

CMD ["/usr/local/sbin/php-fpm", "-F"]

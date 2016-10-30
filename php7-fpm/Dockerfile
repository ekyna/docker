FROM alpine:edge
MAINTAINER Etienne Dauvergne <contact@ekyna.com>

RUN apk add \
        git \
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
    && apk add jpegoptim wkhtmltopdf \
        --update --no-cache --allow-untrusted \
        --repository http://alpine.gliderlabs.com/alpine/edge/testing/ \
    && rm -rf /var/cache/apk/*

COPY config/php.ini /etc/php7/conf.d/50-settings.ini
COPY config/php-fpm.conf /etc/php7/php-fpm.conf

RUN ln -s /usr/bin/php7 /usr/bin/php \
#    && chmod 0700 /etc/php7/conf.d/50-settings.ini \
#    && chmod 0700 /etc/php7/php-fpm.conf \
    && git config --global credential.helper cache \
    && php -r "readfile('https://getcomposer.org/installer');" \
        | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer

EXPOSE 9000

CMD ["php-fpm7", "-F"]

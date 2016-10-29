FROM yavin/alpine-php-fpm:7.0
MAINTAINER Etienne Dauvergne <contact@ekyna.com>

# Packages
RUN apk --update add \
#    php7-apcu \
    php7-bcmath \
    php7-exif \
    php7-soap

	
# Config
COPY php.ini /etc/php7/conf.d/50-setting.ini
COPY php-fpm.conf /etc/php7/php-fpm.conf
	
	
# Composer
RUN php -r "readfile('https://getcomposer.org/installer');" \
    | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer


# Utils
RUN apk add bash jpegoptim wkhtmltopdf \
    --update --no-cache --allow-untrusted \
    --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

# Cleanup
RUN rm -rf /var/cache/apk/*

WORKDIR /app

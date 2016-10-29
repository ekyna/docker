FROM yavin/alpine-php-fpm:7.0
MAINTAINER Etienne Dauvergne <contact@ekyna.com>

RUN apk --update add \
		php7-bcmath \
		php7-exif \
		php7-soap \
	&& php -r "readfile('https://getcomposer.org/installer');" \
		| php -- --install-dir=/usr/local/bin --filename=composer \
		&& chmod +x /usr/local/bin/composer \
	&& apk add jpegoptim wkhtmltopdf \
		--update --no-cache --allow-untrusted \
		--repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
	&& rm -rf /var/cache/apk/*

COPY php.ini /etc/php7/conf.d/50-setting.ini
COPY php-fpm.conf /etc/php7/php-fpm.conf

WORKDIR /app

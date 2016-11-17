FROM nginx:stable-alpine
MAINTAINER Etienne Dauvergne <contact@ekyna.com>

# Create www-data user
RUN addgroup www-data -g 1000 \
    && adduser -D -u 1000 -h /var/www -s /sbin/nologin -G www-data www-data

WORKDIR /var/www

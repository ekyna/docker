FROM alpine:3.4

RUN apk add bash varnish \
    --no-cache --update \
  && rm -rf /var/cache/apk/*

COPY default.vcl /etc/varnish/default.vcl
COPY docker-entrypoint.sh /usr/local/bin/

COPY errors/500.html /var/www/errors/500.html
COPY errors/503.html /var/www/errors/503.html

RUN chmod 0755 /usr/local/bin/docker-entrypoint.sh

ENV VARNISH_PORT 80

#VOLUME "/var/lib/varnish" "/etc/varnish"

EXPOSE 80

ENTRYPOINT ["docker-entrypoint.sh"]

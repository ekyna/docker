FROM alpine:3.4

COPY start.sh /start.sh

RUN apk add varnish \
    --no-cache --update \
  && rm -rf /var/cache/apk/* \
  && chmod +x /start.sh

COPY default.vcl /etc/varnish/default.vcl

VOLUME "/var/lib/varnish"

CMD ["/start.sh"]

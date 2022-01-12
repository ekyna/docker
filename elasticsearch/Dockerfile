FROM elasticsearch:7.16.2

MAINTAINER Etienne Dauvergne <contact@ekyna.com>

COPY docker-healthcheck /usr/local/bin/

HEALTHCHECK CMD ["docker-healthcheck"]

RUN elasticsearch-plugin install --batch analysis-icu

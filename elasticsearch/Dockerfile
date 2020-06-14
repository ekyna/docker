FROM elasticsearch:6.8.10

MAINTAINER Etienne Dauvergne <contact@ekyna.com>

COPY docker-healthcheck /usr/local/bin/

HEALTHCHECK CMD ["docker-healthcheck"]

RUN elasticsearch-plugin install --batch analysis-icu

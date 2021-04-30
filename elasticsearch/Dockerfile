FROM elasticsearch:7.12.1

MAINTAINER Etienne Dauvergne <contact@ekyna.com>

COPY docker-healthcheck /usr/local/bin/

HEALTHCHECK CMD ["docker-healthcheck"]

RUN elasticsearch-plugin install --batch analysis-icu

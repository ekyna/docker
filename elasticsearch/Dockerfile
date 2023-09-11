FROM elasticsearch:7.17.12

MAINTAINER Etienne Dauvergne <contact@ekyna.com>

COPY --chmod="544" docker-healthcheck /usr/local/bin/

HEALTHCHECK CMD ["docker-healthcheck"]

RUN elasticsearch-plugin install --batch analysis-icu

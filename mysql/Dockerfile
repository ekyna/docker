FROM mysql:8.0.27

MAINTAINER Etienne Dauvergne <contact@ekyna.com>

COPY --chmod="544" docker-healthcheck /usr/local/bin/
COPY --chmod="444" config.cnf /etc/mysql/conf.d/custom.cnf

HEALTHCHECK CMD ["docker-healthcheck"]

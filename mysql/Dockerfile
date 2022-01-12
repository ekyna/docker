FROM mysql:8.0.27

MAINTAINER Etienne Dauvergne <contact@ekyna.com>

COPY docker-healthcheck /usr/local/bin/
COPY config.cnf /etc/mysql/conf.d/custom.cnf

RUN chmod 644 /etc/mysql/conf.d/custom.cnf

HEALTHCHECK CMD ["docker-healthcheck"]

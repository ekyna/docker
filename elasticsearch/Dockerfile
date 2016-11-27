FROM elasticsearch:1.7.3
MAINTAINER Etienne Dauvergne <contact@ekyna.com>

RUN mkdir /dump && mkdir /backup
WORKDIR /dump

COPY backup.sh ./backup.sh
RUN chmod +x ./backup.sh

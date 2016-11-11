FROM elasticsearch:1.5.2
MAINTAINER Etienne Dauvergne <contact@ekyna.com>

RUN mkdir /dump && mkdir /backup
WORKDIR /dump

COPY backup.sh ./backup.sh
RUN chmod +x ./backup.sh

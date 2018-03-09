FROM ekyna/php7-fpm:7.1.15
MAINTAINER Etienne Dauvergne <contact@ekyna.com>

RUN apk add \
        openssh \
        supervisor \
        php7-xdebug=2.5.5-r0 \
            --update --no-cache \
    && git config --global credential.helper cache \
    && mkdir /var/run/sshd \
    && mkdir -p /var/log/supervisor \
    && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && ssh-keygen -A \
    && rm -rf /var/cache/apk/*

COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

FROM ekyna/php7-fpm
MAINTAINER Etienne Dauvergne <contact@ekyna.com>

RUN apk add \
        openssh \
        supervisor \
        php7-xdebug=2.5.0-r1 \
            --update --no-cache \
    && mkdir /var/run/sshd \
    && mkdir -p /var/log/supervisor \
    && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && ssh-keygen -A \
    && rm -rf /var/cache/apk/*

COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# XDebug port
EXPOSE 9090
# SSH port
EXPOSE 22

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

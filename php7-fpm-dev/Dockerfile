FROM ekyna/php7-fpm:7.4.26

MAINTAINER Etienne Dauvergne <contact@ekyna.com>

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN apk add \
        openssh \
        supervisor \
        --no-cache \
 && rm -rf /var/cache/apk/* \
 && install-php-extensions xdebug \
 && docker-php-source delete \
 && rm /usr/local/bin/install-php-extensions \
 && git config --global credential.helper cache \
 && mkdir /var/run/sshd \
 && mkdir -p /var/log/supervisor \
 && echo 'root:root' | chpasswd \
 && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
 && ssh-keygen -A

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

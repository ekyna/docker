FROM ekyna/php8-fpm:8.1.8

MAINTAINER Etienne Dauvergne <contact@ekyna.com>

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN set -eux; \
    apk --no-cache add \
        git \
        openssh \
        supervisor; \
    install-php-extensions @composer xdebug; \
    docker-php-source delete; \
    rm /usr/local/bin/install-php-extensions; \
    git config --global credential.helper cache; \
    mkdir /var/run/sshd; \
    mkdir -p /var/log/supervisor; \
    echo 'root:root' | chpasswd; \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config; \
    ssh-keygen -A

COPY supervisord.conf /etc/supervisor/conf.d/php-ssh-dev.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/php-ssh-dev.conf"]

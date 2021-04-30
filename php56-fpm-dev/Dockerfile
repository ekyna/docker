FROM ekyna/php56-fpm

MAINTAINER Etienne Dauvergne <contact@ekyna.com>

ENV NOTVISIBLE "in users profile"

# XDebug
RUN curl -L -o /tmp/xdebug-2.4.0.tgz http://xdebug.org/files/xdebug-2.4.0.tgz \
 && tar xfz /tmp/xdebug-2.4.0.tgz \
 && mkdir -p /usr/src/php/ext \
 && mv xdebug-2.4.0 /usr/src/php/ext/xdebug \
 && docker-php-ext-install xdebug \
 && apt-get update \
 && apt-get install -y --force-yes openssh-server supervisor \
 && mkdir -p /var/run/sshd \
 && mkdir -p /var/log/supervisor \
 && echo 'root:root' | chpasswd \
 && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
 && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
 && echo "export VISIBLE=now" >> /etc/profile \
 && apt-get autoremove -y \
 && apt-get clean all \
 && rm -r /var/lib/apt/lists/*

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose xdebug port
EXPOSE 9090
# Expoe SSH port
EXPOSE 22

CMD ["/usr/bin/supervisord"]

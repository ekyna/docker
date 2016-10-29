FROM ekyna/php7-fpm
MAINTAINER Etienne Dauvergne <contact@ekyna.com>


# Git
RUN apk add git --update --no-cache
# Git password caching
RUN git config --global credential.helper cache


# XDebug
RUN apk add php7-xdebug --update --no-cache \
    --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

# Expose xdebug port
EXPOSE 9090


# SSH server and supervisor
RUN apk add openssh supervisor --update --no-cache \
    && mkdir /var/run/sshd \
    && mkdir -p /var/log/supervisor \
    && echo 'root:root' | chpasswd \
    && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

#RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

# SSH and Supervisor config
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expoe SSH port
EXPOSE 22


# Cleanup
RUN rm -rf /tmp/* /var/cache/apk/*


CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

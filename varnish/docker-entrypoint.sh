#!/bin/sh
set -e

# TODO args/cmd

if [[ ! -f /var/lib/varnish/secret ]]
then
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1 > /var/lib/varnish/secret
fi

if [[ "$1" = "start" ]]
then
    varnishd -a 0.0.0.0:${VARNISH_PORT} \
        -f /etc/varnish/default.vcl \
        -p vcc_allow_inline_c=on \
        -S /var/lib/varnish/secret \
        -s malloc,${VARNISH_MEMORY} \
        -F
fi

exec "$@"

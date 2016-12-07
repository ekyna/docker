#!/bin/sh

mkdir -p /var/lib/varnish/`hostname` && chown nobody /var/lib/varnish/`hostname`

varnishd -a :80 \
         -T localhost:6082 \
         -f /etc/varnish/default.vcl \
         -s malloc,512M
#         -S /etc/varnish/secret

sleep 1

varnishlog

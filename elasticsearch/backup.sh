#!/bin/bash

cd /usr/share/elasticsearch \
    && tar -cf ./elasticsearch.tar data \
    && mv ./elasticsearch.tar /backup

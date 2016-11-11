#!/bin/bash

mysqldump -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} --result-file=./${MYSQL_DATABASE}_dump.sql

mv ./${MYSQL_DATABASE}_dump.sql /backup

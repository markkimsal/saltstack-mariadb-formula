#!/bin/sh
cd /
umask 077

MYSQLADMIN='/usr/bin/mysqladmin --defaults-extra-file=/etc/mysql/debian.cnf'

trap "$MYSQLADMIN shutdown" 0
trap 'exit 2' 1 2 3 15

/usr/bin/mysqld_safe --sql-mode=ANSI_QUOTES >> /var/log/mysql.log 2>&1 & wait
#exec /sbin/setuser root /usr/bin/mysqld_safe --sql-mode=ANSI_QUOTES >> /var/log/mysql.log 2>&1 & wait

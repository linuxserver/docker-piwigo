#!/bin/bash

if [[ $(cat /etc/timezone) != $TZ ]] ; then
  echo "$TZ" > /etc/timezone
  dpkg-reconfigure -f noninteractive tzdata
sed -i -e "s#;date.timezone.*#date.timezone = ${TZ}#g" /etc/php5/fpm/php.ini
sed -i -e "s#;date.timezone.*#date.timezone = ${TZ}#g" /etc/php5/cli/php.ini
fi

#!/bin/bash
mkdir -p /config/www/piwigo
if [ -f "/config/www/piwigo/index.php" ]; then
echo "using existing website"
else
echo "fetching piwigo files"
wget "http://piwigo.org/download/dlcounter.php?code=latest" -O /tmp/piwigo.zip
unzip -q /tmp/piwigo.zip  -d /tmp 
mv /tmp/piwigo/* /config/www/piwigo 
rm -rf /tmp/piwigo /tmp/piwigo.zip
chown -R abc:abc /config/www/piwigo
fi

if [ ! -f "/config/www/piwigo/local/config/config.inc.php" ]; then
cp /config/www/piwigo/include/config_default.inc.php /config/www/piwigo/local/config/config.inc.php
chown abc:abc /config/www/piwigo/local/config/config.inc.php
fi

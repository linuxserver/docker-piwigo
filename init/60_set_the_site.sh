#!/bin/bash
mkdir -p /config/www/gallery
if [ -f "/config/www/gallery/index.php" ]; then
echo "using existing website"
else
echo "fetching piwigo files"
wget "http://piwigo.org/download/dlcounter.php?code=latest" -O /tmp/piwigo.zip
unzip -q /tmp/piwigo.zip  -d /tmp 
mv /tmp/piwigo/* /config/www/gallery 
rm -rf /tmp/piwigo /tmp/piwigo.zip
chown -R abc:abc /config/www/gallery
fi

if [ ! -f "/config/www/gallery/local/config/config.inc.php" ]; then
cp /config/www/gallery/include/config_default.inc.php /config/www/gallery/local/config/config.inc.php
chown abc:abc /config/www/gallery/local/config/config.inc.php
fi

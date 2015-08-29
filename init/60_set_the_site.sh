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


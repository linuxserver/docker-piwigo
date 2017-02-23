FROM lsiobase/alpine.nginx:3.5
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	autoconf \
	curl \
	file \
	g++ \
	gcc \
	imagemagick-dev \
	libtool \
	make \
	php7-dev && \

# install runtime packages
 apk add --no-cache \
	curl \
	imagemagick \
	lynx \
	php7-apcu \
	php7-cgi \
	php7-gd \
	php7-mysqlnd \
	php7-pear \
	php7-xmlrpc \
	php7-xsl \
	re2c \
	unzip \
	wget && \

# install php imagemagick
 mkdir -p \
	/tmp/imagick-src && \
 curl -o \
 /tmp/imagick.tgz -L \
	https://pecl.php.net/get/imagick && \
 tar xf \
 /tmp/imagick.tgz -C \
	/tmp/imagick-src --strip-components=1 && \
 cd /tmp/imagick-src && \
 phpize7 && \
 ./configure \
	--prefix=/usr \
	--with-php-config=/usr/bin/php-config7 && \
 make && \
 make install && \
 echo "extension=imagick.so" > /etc/php7/conf.d/00_imagick.ini && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config /pictures

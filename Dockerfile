FROM lsiobase/alpine.nginx:3.6
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install packages
RUN \
 apk add --no-cache \
	curl \
	imagemagick \
	lynx \
	php7-apcu \
	php7-cgi \
	php7-dom \
	php7-exif \
	php7-gd \
	php7-imagick \
	php7-mysqli \
	php7-mysqlnd \
	php7-pear \
	php7-xmlrpc \
	php7-xsl \
	re2c \
	unzip \
	wget

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config /pictures

FROM lsiobase/alpine.nginx:3.5
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# add repositories
RUN \
 echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
 echo "@community http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \

# install packages
 apk add --no-cache \
	curl \
	lynx \
	re2c \
	unzip \
	wget && \
 apk add --no-cache \
	imagemagick@edge \
	libwebp@edge && \
 apk add --no-cache \
	php7-apcu@community \
	php7-cgi@community \
	php7-dom@community \
	php7-exif@community \
	php7-gd@community \
	php7-imagick@community \
	php7-mysqli@community \
	php7-mysqlnd@community \
	php7-pear@community \
	php7-xmlrpc@community \
	php7-xsl@community

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config /pictures

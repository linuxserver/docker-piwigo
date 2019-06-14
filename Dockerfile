FROM lsiobase/nginx:3.9

# set version label
ARG BUILD_DATE
ARG VERSION
ARG PIWIGO_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache --upgrade \
	curl \
	exiftool \
	ffmpeg \
	imagemagick \
	libjpeg-turbo-utils \
	lynx \
	mediainfo \
	php7-apcu \
	php7-cgi \
	php7-ctype \
	php7-curl \
	php7-dom \
	php7-exif \
	php7-gd \
	php7-imagick \
	php7-ldap \
	php7-mysqli \
	php7-mysqlnd \
	php7-pear \
	php7-xmlrpc \
	php7-xsl \
	poppler-utils \
	re2c \
	unzip \
	wget && \
 echo "**** set version tag ****" && \
 if [ -z ${PIWIGO_RELEASE+x} ]; then \
	PIWIGO_RELEASE=$(curl -sX GET "https://api.github.com/repos/Piwigo/Piwigo/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 echo ${PIWIGO_RELEASE} > /version.txt

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config /pictures

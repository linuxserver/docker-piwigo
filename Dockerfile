FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.15

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
    php8-apcu \
    php8-cgi \
    php8-ctype \
    php8-curl \
    php8-dom \
    php8-exif \
    php8-gd \
    php8-ldap \
    php8-mysqli \
    php8-mysqlnd \
    php8-pear \
    php8-pecl-imagick \
    php8-xsl \
    php8-zip \
    poppler-utils \
    re2c \
    unzip \
    wget && \
  apk add --no-cache \
    --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    php8-pecl-xmlrpc && \
  echo "**** download piwigo ****" && \
  if [ -z ${PIWIGO_RELEASE+x} ]; then \
    PIWIGO_RELEASE=$(curl -sX GET "https://api.github.com/repos/Piwigo/Piwigo/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
  fi && \
  mkdir /piwigo && \
  curl -o \
    /piwigo/piwigo.zip -L \
    "https://piwigo.org/download/dlcounter.php?code=${PIWIGO_RELEASE}" && \
  # The max filesize is 2M by default, which is way to small for most photos
  sed -ri 's/^upload_max_filesize = .*/upload_max_filesize = 100M/' /etc/php8/php.ini && \
  # The max post size is 8M by default, it must be at least max_filesize
  sed -ri 's/^post_max_size = .*/post_max_size = 100M/' /etc/php8/php.ini

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config

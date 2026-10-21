# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.24

# set version label
ARG BUILD_DATE
ARG VERSION
ARG PIWIGO_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thespad"

RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    exiftool \
    ffmpeg \
    imagemagick \
    imagemagick-heic \
    libjpeg-turbo-utils \
    mediainfo \
    php85-apcu \
    php85-cgi \
    php85-ctype \
    php85-curl \
    php85-dom \
    php85-exif \
    php85-gd \
    php85-ldap \
    php85-mysqli \
    php85-mysqlnd \
    php85-pear \
    php85-pecl-imagick \
    php85-xsl \
    php85-zip \
    poppler-utils \
    re2c && \
  echo "**** modify php-fpm process limits ****" && \
  sed -i 's/pm.max_children = 5/pm.max_children = 32/' /etc/php85/php-fpm.d/www.conf && \
  echo "**** configure php-fpm to pass env vars ****" && \
  sed -E -i 's/^;?clear_env ?=.*$/clear_env = no/g' /etc/php85/php-fpm.d/www.conf && \
  if ! grep -qxF 'clear_env = no' /etc/php85/php-fpm.d/www.conf; then echo 'clear_env = no' >> /etc/php85/php-fpm.d/www.conf; fi && \
  echo "env[PATH] = /usr/local/bin:/usr/bin:/bin" >> /etc/php85/php-fpm.conf && \
  echo "**** download piwigo ****" && \
  if [ -z ${PIWIGO_RELEASE+x} ]; then \
    PIWIGO_RELEASE=$(curl -sX GET "https://api.github.com/repos/Piwigo/Piwigo/releases/latest" \
    | jq -r '.tag_name'); \
  fi && \
  mkdir -p /app/www/public && \
  curl -o \
    /tmp/piwigo.zip -L \
    "https://piwigo.org/download/dlcounter.php?code=${PIWIGO_RELEASE}" && \
  unzip -q /tmp/piwigo.zip -d /tmp && \
  mv /tmp/piwigo/* /app/www/public && \
  printf "Linuxserver.io version: ${VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443

VOLUME /config /gallery

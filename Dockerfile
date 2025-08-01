# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.22

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
    php84-apcu \
    php84-cgi \
    php84-ctype \
    php84-curl \
    php84-dom \
    php84-exif \
    php84-gd \
    php84-ldap \
    php84-mysqli \
    php84-mysqlnd \
    php84-pear \
    php84-pecl-imagick \
    php84-xsl \
    php84-zip \
    poppler-utils \
    re2c && \
  echo "**** modify php-fpm process limits ****" && \
  sed -i 's/pm.max_children = 5/pm.max_children = 32/' /etc/php84/php-fpm.d/www.conf && \
  echo "**** configure php-fpm to pass env vars ****" && \
  sed -E -i 's/^;?clear_env ?=.*$/clear_env = no/g' /etc/php84/php-fpm.d/www.conf && \
  if ! grep -qxF 'clear_env = no' /etc/php84/php-fpm.d/www.conf; then echo 'clear_env = no' >> /etc/php84/php-fpm.d/www.conf; fi && \
  echo "env[PATH] = /usr/local/bin:/usr/bin:/bin" >> /etc/php84/php-fpm.conf && \
  echo "**** download piwigo ****" && \
  if [ -z ${PIWIGO_RELEASE+x} ]; then \
    PIWIGO_RELEASE=$(curl -sX GET "https://api.github.com/repos/Piwigo/Piwigo/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
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

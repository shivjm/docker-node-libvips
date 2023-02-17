ARG NODE_VERSION

FROM node:$NODE_VERSION-bullseye

ARG LIBVIPS_VERSION

RUN apt-get update -qq && \
  apt-get install -qqy python git wget libc6=2.31-13+deb11u5 build-essential libglib2.0-dev libgirepository1.0-dev meson \
  libfftw3-dev libexif-dev libjpeg62-turbo-dev \
  libwebp-dev libtiff5-dev libpng-dev \
  libheif-dev libexpat1-dev liborc-0.4-dev \
  liblcms2-dev librsvg2-dev \
  libffi-dev libopenjp2-7-dev \
  libimagequant-dev && \
  echo 'deb http://ftp.debian.org/debian bookworm main' > /etc/apt/sources.list.d/bookworm.list && \
  echo 'APT::Default-Release "stable";' > /etc/apt/apt.conf.d/default-release && \
  apt-get update -qq && \
  apt-get -t bookworm install -qqy libcgif-dev && \
  rm /etc/apt/sources.list.d/bookworm.list && \
  rm /etc/apt/apt.conf.d/default-release && \
  rm -rf /var/lib/apt/lists/*

ENV LIBVIPS_VERSION=$LIBVIPS_VERSION

RUN wget -O /tmp/libvips.tar.gz https://github.com/libvips/libvips/releases/download/v$LIBVIPS_VERSION/vips-$LIBVIPS_VERSION.tar.xz && \
  mkdir /libvips && cd /libvips && \
  tar xf /tmp/libvips.tar.gz --strip-components=1 && \
  meson setup build-dir --buildtype=release && \
  cd build-dir && \
  ninja && \
  ninja test && \
  ninja install && \
  ldconfig && \
  cd .. && \
  rm -rf /libvips /tmp/libvips.tar.gz

ARG PLATFORM=android-23
ARG STAND_TAG=r18b--$PLATFORM--arm-linux-androideabi-4.9

FROM rhardih/stand:$STAND_TAG

# Copy value of platform into final environment
ARG PLATFORM
ENV PLATFORM $PLATFORM

# List of available versions can be found at
# https://download.osgeo.org/libtiff
# https://download.osgeo.org/libtiff/old
ARG VERSION=4.0.10
ARG HOST=arm-linux-androideabi

RUN apt-get update && apt-get -y install \
  wget \
  automake libtool

RUN wget -O tiff-$VERSION.tar.gz \
      https://download.osgeo.org/libtiff/tiff-$VERSION.tar.gz && \
      tar -xzvf tiff-$VERSION.tar.gz && \
      rm tiff-$VERSION.tar.gz

WORKDIR /tiff-$VERSION

ENV PATH $PATH:/$PLATFORM-toolchain/bin

# Acquire newer versions of .guess and .sub files for configure

RUN wget -O config/config.guess \
  https://raw.githubusercontent.com/gcc-mirror/gcc/master/config.guess

RUN wget -O config/config.sub \
  https://raw.githubusercontent.com/gcc-mirror/gcc/master/config.sub

RUN ./autogen.sh

RUN ./configure \
      --host=$HOST \
      --prefix=/tiff-build/

RUN make -j2 && make install

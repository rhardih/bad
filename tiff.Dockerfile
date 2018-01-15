FROM rhardih/stand:r10e--android-21--arm-linux-androideabi-4.9

# List of available versions can be found at
# ftp://download.osgeo.org/libtiff
# ftp://download.osgeo.org/libtiff/old
ARG VERSION=4.0.9

RUN apt-get update && apt-get -y install \
  wget \
  automake libtool

RUN wget -O tiff-$VERSION.tar.gz \
      ftp://download.osgeo.org/libtiff/tiff-$VERSION.tar.gz && \
      tar -xzvf tiff-$VERSION.tar.gz && \
      rm tiff-$VERSION.tar.gz

WORKDIR /tiff-$VERSION

ENV PATH $PATH:/android-21-toolchain/bin

# Acquire newer versions of .guess and .sub files for configure

RUN wget -O config/config.guess \
  https://raw.githubusercontent.com/gcc-mirror/gcc/master/config.guess

RUN wget -O config/config.sub \
  https://raw.githubusercontent.com/gcc-mirror/gcc/master/config.sub

RUN ./autogen.sh

RUN ./configure \
      --host=arm-linux-androideabi \
      --prefix=/tiff-build/

RUN make && make install

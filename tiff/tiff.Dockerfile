ARG PLATFORM=android-23
ARG TOOLCHAIN=arm-linux-androideabi-4.9

FROM rhardih/stand:r18b--$PLATFORM--$TOOLCHAIN

ARG PLATFORM
ENV PLATFORM $PLATFORM
ARG HOST=arm-linux-androideabi

# List of available versions can be found at
# https://download.osgeo.org/libtiff
# https://download.osgeo.org/libtiff/old
ARG VERSION

RUN apt-get update && apt-get -y install \
  wget \
  automake libtool

RUN wget -O tiff-$VERSION.tar.gz \
      https://download.osgeo.org/libtiff/tiff-$VERSION.tar.gz && \
      tar -xzvf tiff-$VERSION.tar.gz && \
      rm tiff-$VERSION.tar.gz

WORKDIR /tiff-$VERSION

ENV PATH /$PLATFORM-toolchain/bin:$PATH

# Acquire newer versions of .guess and .sub files for configure

RUN wget -O config/config.guess \
  https://raw.githubusercontent.com/gcc-mirror/gcc/master/config.guess

RUN wget -O config/config.sub \
  https://raw.githubusercontent.com/gcc-mirror/gcc/master/config.sub

RUN ./autogen.sh

RUN ./configure \
      --host=$HOST \
      --prefix=/tiff-build/

RUN make -j && make install

# Fix b0rked .pc naming
RUN mv /tiff-build/lib/pkgconfig/libtiff-4.pc /tiff-build/lib/pkgconfig/tiff.pc

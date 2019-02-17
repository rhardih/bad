ARG PLATFORM=android-23
ARG STAND_TAG=r18b--$PLATFORM--arm-linux-androideabi-4.9

FROM rhardih/stand:$STAND_TAG

ARG PLATFORM
ENV PLATFORM $PLATFORM

ARG HOST=arm-linux-androideabi

# List of available versions can be found at
# http://download.osgeo.org/geos/
ARG VERSION

RUN apt-get update && apt-get -y install \
  wget \
  bzip2

RUN wget -O geos-$VERSION.tar.bz2 \
  http://download.osgeo.org/geos/geos-$VERSION.tar.bz2 && \
  tar -xjvf geos-$VERSION.tar.bz2 && \
  rm geos-$VERSION.tar.bz2

WORKDIR /geos-$VERSION

ENV PATH $PATH:/android-21-toolchain/bin

RUN ./configure \
  --host=$HOST \
  --prefix=/geos-build/

RUN make && make install

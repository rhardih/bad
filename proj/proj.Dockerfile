ARG PLATFORM=android-23
ARG STAND_TAG=r18b--$PLATFORM--arm-linux-androideabi-4.9

FROM rhardih/stand:$STAND_TAG

ARG HOST=arm-linux-androideabi
ARG PLATFORM
ENV PLATFORM $PLATFORM

# List of available versions can be found at
# https://github.com/OSGeo/proj.4/releases
ARG VERSION=4.9.3

RUN apt-get update && apt-get -y install \
  wget

RUN wget -O proj-$VERSION.tar.gz http://download.osgeo.org/proj/proj-$VERSION.tar.gz && \
      tar -xzvf proj-$VERSION.tar.gz && \
      rm proj-$VERSION.tar.gz

WORKDIR /proj-$VERSION

ENV PATH $PATH:/$PLATFORM-toolchain/bin

RUN ./configure \
  --host=$HOST \
  --prefix=/proj-build/

RUN make -j6 && make install

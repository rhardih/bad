ARG PLATFORM=android-23
ARG TOOLCHAIN=arm-linux-androideabi-4.9

FROM rhardih/stand:r18b--$PLATFORM--$TOOLCHAIN

ARG PLATFORM
ENV PLATFORM $PLATFORM
ARG HOST=arm-linux-androideabi

# List of available versions can be found at
# https://github.com/OSGeo/proj.4/releases
ARG VERSION

RUN apt-get update && apt-get -y install \
  wget

RUN wget -O proj-$VERSION.tar.gz \
  http://download.osgeo.org/proj/proj-$VERSION.tar.gz && \
  tar -xzvf proj-$VERSION.tar.gz && \
  rm proj-$VERSION.tar.gz

WORKDIR /proj-$VERSION

ENV PATH $PATH:/$PLATFORM-toolchain/bin

RUN ./configure \
  --host=$HOST \
  --prefix=/proj-build/

RUN make -j4 && make install

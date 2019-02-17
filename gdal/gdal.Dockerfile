ARG PLATFORM=android-23
ARG STAND_TAG=r18b--$PLATFORM--arm-linux-androideabi-4.9
ARG ARCH=armv7-a

FROM bad-proj:4.9.3-$ARCH AS proj-dep

FROM rhardih/stand:$STAND_TAG

ARG HOST=arm-linux-androideabi
ARG PLATFORM
ENV PLATFORM $PLATFORM

# List of available versions can be found at
# http://download.osgeo.org/gdal/
ARG VERSION

COPY --from=proj-dep /proj-build /proj-build

RUN apt-get update && apt-get -y install \
  bash-completion \
  pkg-config \
  wget

RUN wget -O gdal-$VERSION.tar.gz http://download.osgeo.org/gdal/$VERSION/gdal-$VERSION.tar.gz && \
      tar -xzvf gdal-$VERSION.tar.gz && \
      rm gdal-$VERSION.tar.gz

WORKDIR /gdal-$VERSION

ENV PATH $PATH:/$PLATFORM-toolchain/bin

RUN ./configure \
  --with-proj=/proj-build \
  --host=$HOST \
  --prefix=/gdal-build/

RUN make -j6 && make install

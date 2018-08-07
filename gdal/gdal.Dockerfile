ARG STAND_TAG=r10e--android-21--arm-linux-androideabi-4.9
ARG ARCH=armv7-a

FROM bad-proj:4.9.3-$ARCH AS proj-dep

FROM rhardih/stand:$STAND_TAG

ARG HOST=arm-linux-androideabi

# List of available versions can be found at
# http://download.osgeo.org/gdal/
ARG VERSION=2.3.1

COPY --from=proj-dep /proj-build /proj-build

RUN apt-get update && apt-get -y install \
  bash-completion \
  pkg-config \
  wget

RUN wget -O gdal-$VERSION.tar.gz http://download.osgeo.org/gdal/$VERSION/gdal-$VERSION.tar.gz && \
      tar -xzvf gdal-$VERSION.tar.gz && \
      rm gdal-$VERSION.tar.gz

WORKDIR /gdal-$VERSION

ENV PATH $PATH:/android-21-toolchain/bin

RUN ./configure \
  --with-proj=/proj-build \
  --host=$HOST \
  --prefix=/gdal-build/

RUN make && make install

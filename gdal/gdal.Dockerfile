ARG PLATFORM=android-23
ARG TOOLCHAIN=arm-linux-androideabi-4.9
ARG ARCH=armv7-a

FROM bad-proj:4.9.3-$ARCH AS proj-dep

FROM rhardih/stand:r18b--$PLATFORM--$TOOLCHAIN

ARG PLATFORM
ENV PLATFORM $PLATFORM
ARG HOST=arm-linux-androideabi

# List of available versions can be found at
# http://download.osgeo.org/gdal/
ARG VERSION

COPY --from=proj-dep /proj-build /proj-build

RUN apt-get update && apt-get -y install \
  bash-completion \
  pkg-config \
  wget

RUN wget -O gdal-$VERSION.tar.gz \
  http://download.osgeo.org/gdal/$VERSION/gdal-$VERSION.tar.gz && \
  tar -xzvf gdal-$VERSION.tar.gz && \
  rm gdal-$VERSION.tar.gz

WORKDIR /gdal-$VERSION

ENV PATH $PATH:/$PLATFORM-toolchain/bin

# Changing default linker here, otherwise the error below is thrown for
# arm64-v8a builds:
#
#  /bin/bash /gdal-2.3.1/libtool --mode=link --silent aarch64-linux-android-g++ gdalinfo_bin.lo  /gdal-2.3.1/libgdal.la  -o gdalinfo /android-23-toolchain/bin/../lib/gcc/aarch64-linux-android/4.9.x/../../../../aarch64-linux-android/bin/ld: warning: libproj.so, needed by /gdal-2.3.1/.libs/libgdal.so, not found (try using -rpath or -rpath-link)
ENV LDFLAGS=-fuse-ld=gold

RUN ./configure \
  --with-proj=/proj-build \
  --host=$HOST \
  --prefix=/gdal-build/

RUN make -j4 && make install

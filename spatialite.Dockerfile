FROM bad-sqlite3:3.21.0 AS sqlite3-dep
FROM bad-proj:4.9.3 AS proj-dep
FROM bad-iconv:1.15 AS iconv-dep
FROM bad-geos:3.6.2 AS geos-dep

FROM rhardih/stand:r10e--android-21--arm-linux-androideabi-4.9

# List of available versions can be found at
# http://www.gaia-gis.it/gaia-sins/libspatialite-sources/
ARG VERSION=4.3.0a

COPY --from=sqlite3-dep /sqlite3-build /sqlite3-build
COPY --from=proj-dep /proj-build /proj-build
COPY --from=iconv-dep /iconv-build /iconv-build
COPY --from=geos-dep /geos-build /geos-build

RUN apt-get update && apt-get -y install \
  wget \
  pkg-config \
  autoconf \
  libtool

WORKDIR /

RUN wget -O libspatialite-$VERSION.tar.gz \
  http://www.gaia-gis.it/gaia-sins/libspatialite-sources/libspatialite-$VERSION.tar.gz && \
  tar -xzvf libspatialite-$VERSION.tar.gz && \
  rm libspatialite-$VERSION.tar.gz

WORKDIR /libspatialite-$VERSION

ENV PATH $PATH:/android-21-toolchain/bin
ENV PATH $PATH:/geos-build/bin

ENV PKG_CONFIG_PATH /sqlite3-build/lib/pkgconfig:/proj-build/lib/pkgconfig

# Update "missing" script to avoid error:
# libspatialite-$VERSION/missing: Unknown `--is-lightweight' option
RUN autoreconf -fi

# Acquire newer versions of .guess and .sub files for configure
RUN wget -O config.guess \
  https://raw.githubusercontent.com/gcc-mirror/gcc/master/config.guess

RUN wget -O config.sub \
  https://raw.githubusercontent.com/gcc-mirror/gcc/master/config.sub

RUN CFLAGS=$(pkg-config sqlite3 proj --libs --cflags) \
           CFLAGS="$CFLAGS -I/iconv-build/include -L/iconv-build/lib -liconv" \
           CFLAGS="$CFLAGS -I/geos-build/include -L/geos-build/lib -lgeos" \
           CFLAGS="$CFLAGS -L/android-21-toolchain/sysroot/usr/lib -llog" \
           ./configure --host=arm-linux-androideabi \
           --target=android \
           --disable-freexl \
           --disable-libxml2 \
           --prefix=/spatialite-build/

RUN make && make install

ARG PLATFORM=android-23
ARG TOOLCHAIN=arm-linux-androideabi-4.9
ARG ARCH=armv7-a

FROM bad-sqlite3:3.21.0-$ARCH AS sqlite3-dep
FROM bad-proj:4.9.3-$ARCH AS proj-dep
FROM bad-iconv:1.15-$ARCH AS iconv-dep
FROM bad-geos:3.6.2-$ARCH AS geos-dep

FROM rhardih/stand:r18b--$PLATFORM--$TOOLCHAIN

ARG HOST=arm-linux-androideabi
ARG PLATFORM
ENV PLATFORM $PLATFORM
ARG ARCH
ENV ARCH $ARCH

# List of available versions can be found at
# http://www.gaia-gis.it/gaia-sins/libspatialite-sources/
ARG VERSION

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

ENV PATH $PATH:/$PLATFORM-toolchain/bin
ENV PATH $PATH:/geos-build/bin

# Update "missing" script to avoid error:
# libspatialite-$VERSION/missing: Unknown `--is-lightweight' option
RUN autoreconf -fi

# Acquire newer versions of .guess and .sub files for configure
RUN wget -O config.guess \
  https://raw.githubusercontent.com/gcc-mirror/gcc/master/config.guess

RUN wget -O config.sub \
  https://raw.githubusercontent.com/gcc-mirror/gcc/master/config.sub

# pkg-config is only used for libxml2 it would seem, so is instead used directly
# to set vars for configure
ENV PKG_CONFIG_PATH "/sqlite3-build/lib/pkgconfig"
ENV PKG_CONFIG_PATH "$PKG_CONFIG_PATH:/proj-build/lib/pkgconfig"

RUN pkg-config sqlite3 proj --cflags >> cflags.tmp
RUN pkg-config sqlite3 proj --libs >> ldflags.tmp

# iconv and geos doesn't produce pkg-config .pc files, so those flags are added
# manually
RUN echo "-I/iconv-build/include" >> cflags.tmp
RUN echo "-L/iconv-build/lib -liconv" >> ldflags.tmp

RUN echo "-I/geos-build/include" >> cflags.tmp
RUN echo "-L/geos-build/lib -lgeos" >> cflags.tmp

# Linking log remediates the following run time error:
#   UnsatisfiedLinkError: dlopen failed: cannot locate symbol "__android_log_print"
RUN echo "-L/$PLATFORM-toolchain/sysroot/usr/lib -llog" >> ldflags.tmp

# This is a bit silly, but somehow libgeos_c is needed and incurs a dependency
# for libc++_shared.so only on arm64-v8a, and I haven't found a better way to
# link it
RUN if [ "$ARCH" = "arm64-v8a" ]; then \
      echo "-lgeos_c" >> cflags.tmp; \
      echo "-L/$PLATFORM-toolchain/aarch64-linux-android/lib -lc++_shared" >> ldflags.tmp; \
    fi

RUN CFLAGS=$(tr "\r\n" " " < cflags.tmp) \
  LDFLAGS=$(tr "\r\n" " " < ldflags.tmp) \
  ./configure --host=$HOST \
  --target=android \
  --disable-freexl \
  --disable-libxml2 \
  --disable-examples \
  --prefix=/spatialite-build/

RUN make -j && make install

ARG STAND_TAG=r10e--android-21--arm-linux-androideabi-4.9
ARG ARCH=armv7-a

FROM bad-tiff:4.0.9-$ARCH AS tiff-dep

FROM rhardih/stand:$STAND_TAG

ARG VERSION=1.74.4
ARG HOST=arm-linux-androideabi

COPY --from=tiff-dep /tiff-build /tiff-build

RUN apt-get update && apt-get -y install \
  wget \
  automake \
  libtool \
  pkg-config

RUN wget -O $VERSION.tar.gz \
  https://github.com/DanBloomberg/leptonica/archive/$VERSION.tar.gz && \
  tar -xzvf $VERSION.tar.gz && \
  rm $VERSION.tar.gz

WORKDIR /leptonica-$VERSION

ENV PATH $PATH:/android-21-toolchain/bin
ENV PKG_CONFIG_PATH /tiff-build/lib/pkgconfig

RUN ./autobuild

RUN ./configure \
  --host=$HOST \
  --disable-programs \
  --without-zlib \
  --without-libpng \
  --without-jpeg \
  --without-giflib \
  --without-libwebp \
  --without-libopenjpeg \
  --prefix=/leptonica-build/

RUN make -j2 && make install

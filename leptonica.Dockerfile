FROM bad-tiff:latest AS tiff-dep

FROM rhardih/stand:r10e--android-21--arm-linux-androideabi-4.9

COPY --from=tiff-dep /tiff-build /tiff-build

RUN apt-get update && apt-get -y install \
  wget \
  automake \
  libtool \
  pkg-config

RUN wget -O 1.74.4.tar.gz \
      https://github.com/DanBloomberg/leptonica/archive/1.74.4.tar.gz && \
      tar -xzvf 1.74.4.tar.gz && \
      rm 1.74.4.tar.gz

WORKDIR /leptonica-1.74.4

ENV PATH $PATH:/android-21-toolchain/bin
ENV PKG_CONFIG_PATH /tiff-build/lib/pkgconfig

RUN ./autobuild

RUN ./configure \
      --host=arm-linux-androideabi \
      --disable-programs \
      --without-zlib \
      --without-libpng \
      --without-jpeg \
      --without-giflib \
      --without-libwebp \
      --without-libopenjpeg \
      --prefix=/leptonica-build/

RUN make -j2 && make install

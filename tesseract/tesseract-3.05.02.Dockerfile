ARG PLATFORM=android-23
ARG TOOLCHAIN=arm-linux-androideabi-4.9
ARG ARCH=armv7-a

FROM bad-tiff:4.0.10-$ARCH AS tiff-dep
FROM bad-leptonica:1.74.4-$ARCH AS leptonica-dep

FROM rhardih/stand:r18b--$PLATFORM--$TOOLCHAIN

ARG PLATFORM
ENV PLATFORM $PLATFORM
ARG HOST=arm-linux-androideabi

COPY --from=tiff-dep /tiff-build /tiff-build
COPY --from=leptonica-dep /leptonica-build /leptonica-build

RUN apt-get update && apt-get -y install \
  wget \
  autoconf automake libtool \
  autoconf-archive \
  pkg-config

RUN wget -O 3.05.02.tar.gz \
  https://github.com/tesseract-ocr/tesseract/archive/3.05.02.tar.gz && \
  tar -xzvf 3.05.02.tar.gz && \
  rm 3.05.02.tar.gz

WORKDIR /tesseract-3.05.02

COPY tesseract/patches/3.05.02/configure.ac.patch configure.ac.patch

RUN patch < configure.ac.patch

ENV PATH /$PLATFORM-toolchain/bin:$PATH
ENV PKG_CONFIG_PATH /leptonica-build/lib/pkgconfig:/tiff-build/lib/pkgconfig

RUN ./autogen.sh

# --disable-largefile is added to avoid:
#
#  error: use of undeclared identifier 'fseeko'
#
# See the following issue for further info:
# https://github.com/android-ndk/ndk/issues/442
RUN ./configure \
  ac_cv_c_bigendian=no \
  --host=$HOST \
  --disable-largefile \
  --prefix=/tesseract-build/

RUN make -j4 && make install

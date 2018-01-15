FROM bad-tiff:4.0.9 AS tiff-dep
FROM bad-leptonica:1.74.4 AS leptonica-dep

FROM rhardih/stand:r10e--android-21--arm-linux-androideabi-4.9

ARG VERSION=3.05.01

COPY --from=tiff-dep /tiff-build /tiff-build
COPY --from=leptonica-dep /leptonica-build /leptonica-build

RUN apt-get update && apt-get -y install \
  wget \
  autoconf automake libtool \
  autoconf-archive \
  pkg-config

RUN wget -O $VERSION.tar.gz \
  https://github.com/tesseract-ocr/tesseract/archive/$VERSION.tar.gz && \
  tar -xzvf $VERSION.tar.gz && \
  rm $VERSION.tar.gz

WORKDIR /tesseract-$VERSION

COPY tesseract/configure.ac.patch configure.ac.patch
COPY tesseract/Makefile.am.patch api/Makefile.am.patch

RUN patch < configure.ac.patch
RUN cd api && patch < Makefile.am.patch

ENV PATH $PATH:/android-21-toolchain/bin
ENV PKG_CONFIG_PATH /leptonica-build/lib/pkgconfig/

RUN ./autogen.sh

RUN ./configure \
  --host=arm-linux-androideabi \
  --with-extra-libraries=/leptonica-build/lib \
  --prefix=/tesseract-build/

RUN make -j2  && make install

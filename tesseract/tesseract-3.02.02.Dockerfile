FROM bad-tiff:4.0.9 AS tiff-dep
FROM bad-leptonica:1.74.4 AS leptonica-dep

FROM rhardih/stand:r10e--android-21--arm-linux-androideabi-4.9

COPY --from=tiff-dep /tiff-build /tiff-build
COPY --from=leptonica-dep /leptonica-build /leptonica-build

RUN apt-get update && apt-get -y install \
  wget \
  autoconf automake libtool \
  autoconf-archive \
  pkg-config

RUN wget -O 3.02.02.tar.gz \
  https://github.com/tesseract-ocr/tesseract/archive/3.02.02.tar.gz && \
  tar -xzvf 3.02.02.tar.gz && \
  rm 3.02.02.tar.gz

WORKDIR /tesseract-3.02.02

COPY tesseract/patches/3.02.02/1 1

RUN patch -p1 < 1

ENV PATH $PATH:/android-21-toolchain/bin
ENV PKG_CONFIG_PATH /leptonica-build/lib/pkgconfig/
ENV LIBLEPT_HEADERSDIR /leptonica-build/include/leptonica

RUN ./autogen.sh

RUN ./configure \
  --host=arm-linux-androideabi \
  --with-extra-libraries=/leptonica-build/lib \
  --prefix=/tesseract-build/

RUN make -j2  && make install

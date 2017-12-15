FROM bad-liblept:latest AS leptonica-dep

FROM rhardih/stand:r10e--android-21--arm-linux-androideabi-4.9

COPY --from=leptonica-dep /leptonica-build /leptonica-build

RUN apt-get update && apt-get -y install \
  wget \
  autoconf automake libtool \
  autoconf-archive \
  pkg-config

RUN wget -O 3.05.01.tar.gz \
      https://github.com/tesseract-ocr/tesseract/archive/3.05.01.tar.gz && \
      tar -xzvf 3.05.01.tar.gz && \
      rm 3.05.01.tar.gz

WORKDIR /tesseract-3.05.01

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

ARG PLATFORM=android-23
ARG TOOLCHAIN=arm-linux-androideabi-4.9

FROM rhardih/stand:r18b--$PLATFORM--$TOOLCHAIN

ARG PLATFORM
ENV PLATFORM $PLATFORM
ARG HOST=arm-linux-androideabi

# List of available versions can be found at
# https://ftp.gnu.org/pub/gnu/libiconv/
ARG VERSION

RUN apt-get update && apt-get -y install \
  wget

RUN wget -O libiconv-$VERSION.tar.gz \
  https://ftp.gnu.org/pub/gnu/libiconv/libiconv-$VERSION.tar.gz && \
  tar -xzvf libiconv-$VERSION.tar.gz && \
  rm libiconv-$VERSION.tar.gz

WORKDIR /libiconv-$VERSION

ENV PATH /$PLATFORM-toolchain/bin:$PATH

RUN ./configure \
  --host=$HOST \
  --prefix=/iconv-build/

RUN make -j4 && make install

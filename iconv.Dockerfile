FROM rhardih/stand:r10e--android-21--arm-linux-androideabi-4.9

# List of available versions can be found at
# https://ftp.gnu.org/pub/gnu/libiconv/
ARG VERSION=1.15

RUN apt-get update && apt-get -y install \
  wget

RUN wget -O libiconv-$VERSION.tar.gz \
  https://ftp.gnu.org/pub/gnu/libiconv/libiconv-$VERSION.tar.gz && \
  tar -xzvf libiconv-$VERSION.tar.gz && \
  rm libiconv-$VERSION.tar.gz

WORKDIR /libiconv-$VERSION

ENV PATH $PATH:/android-21-toolchain/bin

RUN ./configure --host=arm-linux-androideabi --prefix=/iconv-build/

RUN make && make install

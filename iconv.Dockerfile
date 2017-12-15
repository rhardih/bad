FROM rhardih/stand:r10e--android-21--arm-linux-androideabi-4.9

RUN apt-get update && apt-get -y install \
  wget

RUN wget -O libiconv-1.15.tar.gz https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz && \
      tar -xzvf libiconv-1.15.tar.gz && \
      rm libiconv-1.15.tar.gz

WORKDIR /libiconv-1.15

ENV PATH $PATH:/android-21-toolchain/bin

RUN ./configure --host=arm-linux-androideabi --prefix=/iconv-build/

RUN make && make install

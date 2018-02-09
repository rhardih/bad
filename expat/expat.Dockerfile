ARG STAND_TAG=r10e--android-21--arm-linux-androideabi-4.9

FROM rhardih/stand:$STAND_TAG

ARG VERSION=2.2.5
ARG HOST=arm-linux-androideabi

RUN apt-get update && apt-get -y install \
  wget \
  autoconf \
  libtool

RUN wget -O $VERSION.tar.bz2 \
  https://github.com/libexpat/libexpat/releases/download/R_2_2_5/expat-$VERSION.tar.bz2 && \
  tar -xjvf $VERSION.tar.bz2 && \
  rm $VERSION.tar.bz2

WORKDIR /expat-$VERSION

ENV PATH $PATH:/android-21-toolchain/bin

RUN autoreconf -vfi

RUN ./configure \
	--host=$HOST \
  --prefix=/expat-build/

RUN make -j2 && make install

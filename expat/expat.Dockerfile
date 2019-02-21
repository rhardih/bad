ARG PLATFORM=android-23
ARG TOOLCHAIN=arm-linux-androideabi-4.9

FROM rhardih/stand:r18b--$PLATFORM--$TOOLCHAIN

ARG VERSION
ARG HOST=arm-linux-androideabi
ARG PLATFORM

ENV PLATFORM $PLATFORM

RUN apt-get update && apt-get -y install \
  wget \
  autoconf \
  libtool

# TODO: Fix R_2_2_5 explicit version dependence
RUN wget -O $VERSION.tar.bz2 \
  https://github.com/libexpat/libexpat/releases/download/R_2_2_5/expat-$VERSION.tar.bz2 && \
  tar -xjvf $VERSION.tar.bz2 && \
  rm $VERSION.tar.bz2

WORKDIR /expat-$VERSION

ENV PATH /$PLATFORM-toolchain/bin:$PATH

RUN autoreconf -vfi

RUN ./configure \
	--host=$HOST \
  --prefix=/expat-build/

RUN make -j4 && make install

ARG STAND_TAG=r10e--android-21--arm-linux-androideabi-4.9
ARG ARCH=armv7-a

FROM bad-expat:2.2.5-$ARCH as expat-dep

FROM rhardih/stand:$STAND_TAG

ARG VERSION=2.2.26
ARG HOST=arm-linux-androideabi

COPY --from=expat-dep /expat-build /expat-build

RUN apt-get update && apt-get -y install \
  wget \
  pkg-config \
  texinfo \
  autoconf \
  libtool

RUN wget -O $VERSION.tar.gz \
	https://github.com/Unidata/UDUNITS-2/archive/v$VERSION.tar.gz && \
  tar -xzvf $VERSION.tar.gz && \
  rm $VERSION.tar.gz

WORKDIR /UDUNITS-2-$VERSION

ENV PATH $PATH:/android-21-toolchain/bin
ENV PKG_CONFIG_PATH /expat-build/lib/pkgconfig

RUN autoreconf -vfi

RUN CFLAGS=$(pkg-config expat --libs --cflags) \
  ./configure \
  --host=$HOST \
  --prefix=/udunits-2-build/

RUN make -j2 && make install

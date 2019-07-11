ARG PLATFORM=android-23
ARG TOOLCHAIN=arm-linux-androideabi-4.9
ARG ARCH=armv7-a

FROM bad-expat:2.2.5-$ARCH as expat-dep

FROM rhardih/stand:r18b--$PLATFORM--$TOOLCHAIN

ARG VERSION
ARG HOST=arm-linux-androideabi
ARG PLATFORM

ENV PLATFORM $PLATFORM

COPY --from=expat-dep /expat-build /expat-build

RUN apt-get update && apt-get -y install \
  wget \
  pkg-config \
  texinfo \
  autoconf \
  libtool \
  flex \
  bison

RUN wget -O $VERSION.tar.gz \
	https://github.com/Unidata/UDUNITS-2/archive/v$VERSION.tar.gz && \
  tar -xzvf $VERSION.tar.gz && \
  rm $VERSION.tar.gz

WORKDIR /UDUNITS-2-$VERSION

ENV PATH $PATH:/$PLATFORM-toolchain/bin
ENV PKG_CONFIG_PATH /expat-build/lib/pkgconfig

RUN autoreconf -vfi

RUN CFLAGS=$(pkg-config expat --cflags) \
  LDFLAGS=$(pkg-config expat --libs) \
  ./configure \
  --host=$HOST \
  --prefix=/udunits-2-build/

RUN make -j4 && make install

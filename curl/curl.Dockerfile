ARG PLATFORM=android-23
ARG TOOLCHAIN=arm-linux-androideabi-4.9
ARG ARCH=arm64-v8a

FROM bad-openssl:1.1.1c-$ARCH AS openssl-dep
FROM rhardih/stand:r18b--$PLATFORM--$TOOLCHAIN

ARG VERSION
ARG HOST=arm-linux-androideabi
ARG PLATFORM

ENV PLATFORM $PLATFORM

COPY --from=openssl-dep /openssl-build /openssl-build

RUN apt-get update && apt-get -y install \
  wget

RUN wget -O libcurl-$VERSION.tar.gz \
  https://curl.haxx.se/download/curl-$VERSION.tar.gz && \
  tar -xzvf libcurl-$VERSION.tar.gz && \
  rm libcurl-$VERSION.tar.gz

WORKDIR /curl-$VERSION

ENV PATH $PATH:/$PLATFORM-toolchain/bin
ENV LDFLAGS -R/openssl-build/lib

RUN LDFLAGS=-Wl,-R/openssl-build/lib ./configure \
    --with-ssl=/openssl-build \
    --host=$HOST\
    --prefix=/curl-build/ 

RUN make -j && make install

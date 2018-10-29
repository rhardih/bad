ARG STAND_TAG=r10e--android-21--arm-linux-androideabi-4.9

FROM rhardih/stand:$STAND_TAG

# List of available versions can be found at
# https://www.openssl.org/source/
# https://www.openssl.org/source/old/
ARG VERSION=1.0.2p

# This is a base set of environment variables as seen in
# https://wiki.openssl.org/images/7/70/Setenv-android.sh
ARG ANDROID_EABI=arm-linux-androideabi-4.9
ARG ANDROID_API=android-21
ARG MACHINE=armv7
ARG SYSTEM=android
ARG ARCH=arm
ARG CROSS_COMPILE=arm-linux-androideabi-
ARG OS_COMPILER=android-armv7

RUN apt-get update && apt-get -y install \
  wget

RUN wget -O openssl-$VERSION.tar.gz \
  https://www.openssl.org/source/openssl-$VERSION.tar.gz && \
  wget https://www.openssl.org/source/openssl-$VERSION.tar.gz.sha1 && \
  sed "s/$/  openssl-$VERSION.tar.gz/" openssl-$VERSION.tar.gz.sha1 > openssl.sha1 && \
  sha1sum -c openssl.sha1 && \
  tar -xzvf openssl-$VERSION.tar.gz && \
  rm openssl-$VERSION.tar.gz && \
  rm openssl-$VERSION.tar.gz.sha1 openssl.sha1

WORKDIR /openssl-$VERSION

ENV PATH=$PATH:/$ANDROID_API-toolchain/bin \
  ANDROID_ARCH=android-$ARCH \
  ANDROID_EABI=$ANDROID_EABI \
  ANDROID_API=$ANDROID_API \
  ANDROID_TOOLCHAIN=/$ANDROID_API-toolchain/bin \
  MACHINE=$MACHINE \
  SYSTEM=$SYSTEM \
  ARCH=$ARCH \
  CROSS_COMPILE=$CROSS_COMPILE \
  ANDROID_DEV=/$ANDROID_API-toolchain/usr

RUN ./Configure \
  --prefix=/openssl-build/ \
  --openssldir=/openssl-build/ \
  shared $OS_COMPILER

# CALC_VERSIONS is set in order to build versionless copies since Android
# doesn't support versioned shared libs.
RUN make -j depend && \
  make -j CALC_VERSIONS="SHLIB_COMPAT=; SHLIB_SOVER=" build_libs && \
  make install

FROM rhardih/stand:r10e--android-21--arm-linux-androideabi-4.9

# List of available versions can be found at
# https://www.openssl.org/source/
# https://www.openssl.org/source/old/
ARG VERSION=1.0.2.n

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

ENV PATH $PATH:/android-21-toolchain/bin

# This is a base set of envrironment variables as seen in
# https://wiki.openssl.org/images/7/70/Setenv-android.sh

ENV ANDROID_ARCH arch-arm
ENV ANDROID_EABI arm-linux-androideabi-4.9
ENV ANDROID_API android-21

ENV ANDROID_TOOLCHAIN /android-21-toolchain/bin

# Defaults
ENV MACHINE armv7
ENV RELEASE 2.6.37
ENV SYSTEM android
ENV ARCH arm
ENV CROSS_COMPILE arm-linux-androideabi-

ENV ANDROID_DEV /android-21-toolchain/usr

RUN ./Configure shared android-armv7 \
  --prefix=/openssl-build/ \
  --openssldir=/openssl-build/

# CALC_VERSIONS is set in order to build versionless copies since Android
# doesn't support versioned shared libs.
RUN make -j depend && \
  make -j CALC_VERSIONS="SHLIB_COMPAT=; SHLIB_SOVER=" build_libs && \
  make install

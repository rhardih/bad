FROM rhardih/stand:r10e--android-21--arm-linux-androideabi-4.9

RUN apt-get update && apt-get -y install \
      wget

RUN wget -O openssl-1.1.0g.tar.gz \
      https://www.openssl.org/source/openssl-1.1.0g.tar.gz && \
      tar -xzvf openssl-1.1.0g.tar.gz && \
      rm openssl-1.1.0g.tar.gz

WORKDIR /openssl-1.1.0g

ENV PATH $PATH:/android-21-toolchain/bin

# This is a base set of envrironment variables as seen in
# https://wiki.openssl.org/images/7/70/Setenv-android.sh

ENV ANDROID_ARCH arch-arm
ENV ANDROID_EABI arm-linux-androideabi-4.9
ENV ANDROID_API android-21

ENV CROSS_SYSROOT /android-21-toolchain/sysroot

# Defaults
ENV MACHINE armv7
ENV RELEASE 2.6.37
ENV SYSTEM android
ENV ARCH arm
ENV CROSS_COMPILE arm-linux-androideabi-

ENV ANDROID_DEV $SYSROOT/usr

RUN ./config shared no-ssl3 no-comp no-hw no-engine

RUN ./Configure --prefix=/openssl-build/ \
  shared android

RUN make -j && make install

ARG PLATFORM=android-23
ARG TOOLCHAIN=arm-linux-androideabi-4.9
ARG ARCH=armv7-a

FROM bad-leptonica:1.74.4-$ARCH AS leptonica-dep

# No need to use a stand container, if we're installing a full toolchain anyway
FROM rhardih/stand:r18b--$PLATFORM--$TOOLCHAIN

# Copy value of platform into final environment
ARG PLATFORM
ENV PLATFORM $PLATFORM
ARG VERSION=4.0.0

COPY --from=leptonica-dep /leptonica-build /leptonica-build

RUN apt-get update && apt-get -y install \
  wget \
  cmake \
  pkg-config

# Build version with fix for missing glob.h on Android.
#
# See the following for diff against origin:
# VERSION: [4.0.0, 4.1.0]
# https://github.com/tesseract-ocr/tesseract/compare/$VERSION...rhardih:$VERSION-rhardih
RUN wget -O $VERSION.tar.gz \
  https://github.com/rhardih/tesseract/archive/$VERSION-rhardih.tar.gz && \
  tar -xzvf $VERSION.tar.gz && \
  rm $VERSION.tar.gz

WORKDIR /tesseract-$VERSION-rhardih

ENV PKG_CONFIG_PATH /leptonica-build/lib/pkgconfig/

RUN mkdir build
WORKDIR build

RUN cmake \
  -D CMAKE_C_COMPILER=/$PLATFORM-toolchain/bin/clang \
  -D CMAKE_CXX_COMPILER=/$PLATFORM-toolchain/bin/clang++ \
  -D ANDROID=ON \
  -D BUILD_TESTS=OFF \
  -D BUILD_TRAINING_TOOLS=OFF \
  -D CMAKE_BUILD_TYPE=Release \
  -D CMAKE_INSTALL_PREFIX:PATH=/tesseract-build \
  -D CPPAN_BUILD=OFF \
  ..

RUN make -j4
RUN make install

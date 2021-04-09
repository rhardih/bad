ARG PLATFORM=android-21
ARG TOOLCHAIN=arm-linux-androideabi-4.9

FROM rhardih/stand:r10e--$PLATFORM--$TOOLCHAIN

ARG VERSION
ARG PLATFORM
ENV PLATFORM $PLATFORM
ARG HOST=arm-linux-androideabi
ARG ANDROID_ABI=armeabi-v7a
ARG SCRIPT_NAME=cmake_android_arm
ARG SCRIPT_ARCH=arm
ARG WITH_OPENCL=ON

RUN apt-get update && apt-get -y install \
  wget \
  cmake

RUN wget -O $VERSION.tar.gz \
  https://github.com/opencv/opencv/archive/$VERSION.tar.gz && \
  tar -xzvf $VERSION.tar.gz && \
  rm $VERSION.tar.gz

RUN wget -O $VERSION.tar.gz \
  https://github.com/opencv/opencv_contrib/archive/$VERSION.tar.gz && \
  tar -xzvf $VERSION.tar.gz && \
  rm $VERSION.tar.gz

WORKDIR /opencv-$VERSION

ENV PATH $PATH:/$PLATFORM-toolchain/bin
ENV ANDROID_STANDALONE_TOOLCHAIN /$PLATFORM-toolchain

RUN mkdir -p build_android_$SCRIPT_ARCH
WORKDIR build_android_$SCRIPT_ARCH

RUN cmake \
  -DCMAKE_TOOLCHAIN_FILE=../platforms/android/android.toolchain.cmake \
  -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
  -D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib-$VERSION/modules \
  -D BUILD_SHARED_LIBS=ON \
  -D BUILD_ZLIB=ON \
  -D ANDROID_SDK_ROOT=$ANDROID_STANDALONE_TOOLCHAIN \
  -D ANDROID_ABI=$ANDROID_ABI \
  -D ANDROID_NATIVE_API_LEVEL=21 \
  -D ANDROID_SDK_TARGET=android-25 \
  -D WITH_CAROTENE=ON \
  -D WITH_QT=OFF \
  -D WITH_OPENGL=ON \
  -D CMAKE_BUILD_TYPE=Release \
  -D BUILD_TESTS=OFF \
  -D BUILD_PERF_TESTS=OFF \
  -D BUILD_ANDROID_EXAMPLES=OFF \
  -D BUILD_JAVA=OFF \
  -D 3P_LIBRARY_OUTPUT_PATH=/opencv-build/sdk/native/libs/$ANDROID_ABI/ \
  -D WITH_OPENCL=$WITH_OPENCL \
  -D CMAKE_INSTALL_PREFIX:PATH=/opencv-build \
  ..

RUN make -j && make install

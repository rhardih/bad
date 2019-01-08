ARG PLATFORM=android-23
ARG STAND_TAG=r18b--$PLATFORM--arm-linux-androideabi-4.9
ARG ARCH=armv7-a

FROM bad-leptonica:1.74.4-$ARCH AS leptonica-dep

FROM rhardih/stand:$STAND_TAG

# Copy value of platform into final environment
ARG PLATFORM
ENV PLATFORM $PLATFORM

COPY --from=leptonica-dep /leptonica-build /leptonica-build

RUN apt-get update && apt-get -y install \
  wget \
  pkg-config \
  unzip \
  default-jre

RUN wget -O sdk.zip \
  https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
  unzip -d /android-sdk sdk.zip && \
  rm sdk.zip

ENV PATH $PATH:/android-sdk/tools/bin

# Fix for obscure java error when running sdkmanager
ENV JAVA_OPTS -XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee

RUN yes | sdkmanager --licenses
RUN sdkmanager --install "cmake;3.6.4111459"

ENV PATH $PATH:/android-sdk/cmake/3.6.4111459/bin

RUN sdkmanager --install ndk-bundle

ENV STEP 05

RUN wget -O 4.0.0.tar.gz \
  https://github.com/rhardih/tesseract/archive/4.0.0-rhardih-$STEP.tar.gz && \
  tar -xzvf 4.0.0.tar.gz && \
  rm 4.0.0.tar.gz

WORKDIR /tesseract-4.0.0-rhardih-$STEP

ENV PKG_CONFIG_PATH /leptonica-build/lib/pkgconfig/

RUN mkdir build
WORKDIR build

RUN cmake \
  -G "Android Gradle - Ninja" \
  -D ANDROID_ABI=armeabi-v7a \
  -D ANDROID_NATIVE_API_LEVEL=23 \
  -D BUILD_TESTS=OFF \
  -D BUILD_TRAINING_TOOLS=OFF \
  -D CMAKE_BUILD_TYPE=Release \
  -D CMAKE_INSTALL_PREFIX:PATH=/tesseract-build \
  -D CMAKE_MAKE_PROGRAM=/android-sdk/cmake/3.6.4111459/bin/ninja \
  -D CMAKE_TOOLCHAIN_FILE=/android-sdk/ndk-bundle/build/cmake/android.toolchain.cmake \
  -D CPPAN_BUILD=OFF \
  ..
 
RUN ninja -j8
RUN ninja install

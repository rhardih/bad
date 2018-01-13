FROM bad-leptonica:latest AS leptonica-dep
FROM bad-tesseract:latest AS tesseract-dep

FROM rhardih/stand:r10e--android-21--arm-linux-androideabi-4.9

COPY --from=leptonica-dep /leptonica-build /leptonica-build
COPY --from=tesseract-dep /tesseract-build /tesseract-build

RUN apt-get update && apt-get -y install \
      wget \
      cmake

RUN wget -O 3.3.1.tar.gz \
      https://github.com/opencv/opencv/archive/3.3.1.tar.gz && \
			tar -xzvf 3.3.1.tar.gz && \
      rm 3.3.1.tar.gz

RUN wget -O 3.3.1.tar.gz \
      https://github.com/opencv/opencv_contrib/archive/3.3.1.tar.gz && \
      tar -xzvf 3.3.1.tar.gz && \
      rm 3.3.1.tar.gz

WORKDIR /opencv-3.3.1

ENV PATH $PATH:/android-21-toolchain/bin
ENV ARCH armeabi-v7a
ENV ANDROID_STANDALONE_TOOLCHAIN /android-21-toolchain

RUN ./platforms/scripts/cmake_android_arm.sh \
      -D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib-3.3.1/modules \
      -D BUILD_SHARED_LIBS=ON \
      -D BUILD_ZLIB=ON \
      -D ANDROID_ABI=$ARCH \
      -D ANDROID_NATIVE_API_LEVEL=21 \
      -D ANDROID_SDK_TARGET=android-25 \
      -D WITH_CAROTENE=ON \
      -D WITH_QT=ON \
      -D WITH_OPENGL=ON \
      -D CMAKE_BUILD_TYPE=Release \
      -D BUILD_TESTS=OFF \
      -D BUILD_PERF_TESTS=OFF \
      -D BUILD_ANDROID_EXAMPLES=OFF \
      -D WITH_TESSERACT=ON \
      -D Tesseract_INCLUDE_DIR=/tesseract-build/include \
      -D Tesseract_LIBRARY=/tesseract-build/libtesseract.so \
      -D Lept_LIBRARY=/leptonica-build/lib/liblept.so \
      -D CMAKE_INSTALL_PREFIX:PATH=/opencv-build

WORKDIR /opencv-3.3.1/platforms/build_android_arm

RUN make -j2 && make install

# Copy 3rdparty libs
RUN cp 3rdparty/lib/armeabi-v7a/* /opencv-build/sdk/native/libs/armeabi-v7a/

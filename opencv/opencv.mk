opencv-x86/%: leptonica-x86/1.74.4 tesseract-x86/3.02.02
	docker build --build-arg VERSION=${@F} \
		--build-arg STAND_TAG=r10e--android-21--x86-4.9 \
		--build-arg HOST=i686-linux-android \
		--build-arg ARCH=x86 \
		--build-arg ANDROID_ABI=x86 \
		--build-arg SCRIPT_NAME=cmake_android_x86 \
		--build-arg SCRIPT_ARCH=x86 \
		-t bad-opencv:${@F}-x86 -f opencv/opencv.Dockerfile ${BUILD_ARGS} .

opencv-armv7-a/%: leptonica-armv7-a/1.74.4 tesseract-armv7-a/3.02.02
	docker build --build-arg VERSION=${@F} \
		-t bad-opencv:${@F}-armv7-a -f opencv/opencv.Dockerfile ${BUILD_ARGS} .

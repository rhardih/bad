opencv-x86/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg TOOLCHAIN=x86-4.9 \
		--build-arg HOST=i686-linux-android \
		--build-arg ARCH=x86 \
		--build-arg ANDROID_ABI=x86 \
		--build-arg SCRIPT_NAME=cmake_android_x86 \
		--build-arg SCRIPT_ARCH=x86 \
		-t bad-opencv:${@F}-x86 -f opencv/opencv.Dockerfile ${BUILD_ARGS} .

opencv-arm64-v8a/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=aarch64-linux-android \
		--build-arg TOOLCHAIN=aarch64-linux-android-4.9 \
		--build-arg ARCH=arm64-v8a \
		--build-arg ANDROID_ABI=arm64-v8a \
		--build-arg SCRIPT_NAME=cmake_android_arm64-v8a \
		--build-arg SCRIPT_ARCH=arm64-v8a \
		-t bad-opencv:${@F}-arm64-v8a -f opencv/opencv.Dockerfile ${BUILD_ARGS} .

opencv-armv7-a/%:
	docker build --build-arg VERSION=${@F} \
		-t bad-opencv:${@F}-armv7-a -f opencv/opencv.Dockerfile ${BUILD_ARGS} .

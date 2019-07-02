openssl-x86/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg TOOLCHAIN=x86-4.9 \
		--build-arg ANDROID_EABI=x86-4.9 \
		--build-arg ANDROID_API=android-21 \
		--build-arg MACHINE=i686 \
		--build-arg ARCH=x86 \
		--build-arg CROSS_COMPILE=i686-linux-android- \
		--build-arg OS_COMPILER=android-x86 \
		-t bad-openssl:${@F}-x86 -f openssl/openssl.Dockerfile ${BUILD_ARGS} .

openssl-arm64-v8a/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg TOOLCHAIN=aarch64-linux-android-4.9 \
		--build-arg ANDROID_EABI=aarch64-linux-android \
		--build-arg ANDROID_API=android-21 \
		--build-arg MACHINE=aarch64 \
		--build-arg CROSS_COMPILE=aarch64-linux-android- \
		--build-arg OS_COMPILER=linux-aarch64 \
		-t bad-openssl:${@F}-arm64-v8a -f openssl/openssl.Dockerfile ${BUILD_ARGS} .

openssl-armv7-a/%:
	docker build --build-arg VERSION=${@F} \
		-t bad-openssl:${@F}-armv7-a -f openssl/openssl.Dockerfile ${BUILD_ARGS} .

leptonica-x86/%: tiff-x86/4.0.9
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=i686-linux-android \
		--build-arg TOOLCHAIN=x86-4.9 \
		--build-arg ARCH=x86 \
		-t bad-leptonica:${@F}-x86 \
		-f leptonica/leptonica.Dockerfile ${BUILD_ARGS} .

leptonica-arm64-v8a/%: tiff-arm64-v8a/4.0.10
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=aarch64-linux-android \
		--build-arg TOOLCHAIN=aarch64-linux-android-4.9 \
		--build-arg ARCH=arm64-v8a \
		-t bad-leptonica:${@F}-arm64-v8a \
		-f leptonica/leptonica.Dockerfile ${BUILD_ARGS} .

leptonica-armv7-a/%: tiff-armv7-a/4.0.10
	docker build --build-arg VERSION=${@F} \
		-t bad-leptonica:${@F}-armv7-a \
		-f leptonica/leptonica.Dockerfile ${BUILD_ARGS} .


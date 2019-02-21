tiff-x86/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=i686-linux-android \
		--build-arg TOOLCHAIN=x86-4.9 \
		-t bad-tiff:${@F}-x86 -f tiff/tiff.Dockerfile ${BUILD_ARGS} .

tiff-arm64-v8a/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=aarch64-linux-android \
		--build-arg TOOLCHAIN=aarch64-linux-android-4.9 \
		-t bad-tiff:${@F}-arm64-v8a -f tiff/tiff.Dockerfile ${BUILD_ARGS} .

tiff-armv7-a/%:
	docker build --build-arg VERSION=${@F} \
		-t bad-tiff:${@F}-armv7-a -f tiff/tiff.Dockerfile ${BUILD_ARGS} .

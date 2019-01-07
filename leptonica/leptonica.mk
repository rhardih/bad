leptonica-x86/%: tiff-x86/4.0.9
	docker build --build-arg VERSION=${@F} \
		--build-arg STAND_TAG=r10e--android-21--x86-4.9 \
		--build-arg HOST=i686-linux-android \
		--build-arg ARCH=x86 \
		-t bad-leptonica:${@F}-x86 \
		-f leptonica/leptonica.Dockerfile ${BUILD_ARGS} .

leptonica-armv7-a/%: tiff-armv7-a/4.0.10
	docker build --build-arg VERSION=${@F} \
		-t bad-leptonica:${@F}-armv7-a \
		-f leptonica/leptonica.Dockerfile ${BUILD_ARGS} .


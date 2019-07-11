udunits-2-x86/%: expat-x86/2.2.5
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=i686-linux-android \
		--build-arg TOOLCHAIN=x86-4.9 \
		--build-arg ARCH=x86 \
		-t bad-udunits-2:${@F}-x86 -f udunits-2/udunits-2.Dockerfile ${BUILD_ARGS} .

udunits-2-arm64-v8a/%: expat-arm64-v8a/2.2.5
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=aarch64-linux-android \
		--build-arg TOOLCHAIN=aarch64-linux-android-4.9 \
		--build-arg ARCH=arm64-v8a \
		-t bad-udunits-2:${@F}-arm64-v8a -f udunits-2/udunits-2.Dockerfile ${BUILD_ARGS} .

udunits-2-armv7-a/%: expat-armv7-a/2.2.5
	docker build --build-arg VERSION=${@F} \
		-t bad-udunits-2:${@F}-armv7-a -f udunits-2/udunits-2.Dockerfile ${BUILD_ARGS} .

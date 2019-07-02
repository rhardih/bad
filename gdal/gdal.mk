gdal-x86/%: proj-x86/4.9.3
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=i686-linux-android \
		--build-arg TOOLCHAIN=x86-4.9 \
		--build-arg ARCH=x86 \
		-t bad-gdal:${@F}-x86 -f gdal/gdal.Dockerfile ${BUILD_ARGS} .

gdal-arm64-v8a/%: proj-arm64-v8a/4.9.3
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=aarch64-linux-android \
		--build-arg TOOLCHAIN=aarch64-linux-android-4.9 \
		--build-arg ARCH=arm64-v8a \
		-t bad-gdal:${@F}-arm64-v8a -f gdal/gdal.Dockerfile ${BUILD_ARGS} .

gdal-armv7-a/%: proj-armv7-a/4.9.3
	docker build --build-arg VERSION=${@F} \
		-t bad-gdal:${@F}-armv7-a -f gdal/gdal.Dockerfile ${BUILD_ARGS} .

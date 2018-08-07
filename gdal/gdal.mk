gdal-x86/%: proj-x86/4.9.3
	docker build --build-arg VERSION=${@F} \
		--build-arg STAND_TAG=r10e--android-21--x86-4.9 \
		--build-arg HOST=i686-linux-android \
		--build-arg ARCH=x86 \
		-t bad-gdal:${@F}-x86 -f gdal/gdal.Dockerfile ${BUILD_ARGS} .

gdal-armv7-a/%: proj-armv7-a/4.9.3
	docker build --build-arg VERSION=${@F} \
		-t bad-gdal:${@F}-armv7-a -f gdal/gdal.Dockerfile ${BUILD_ARGS} .

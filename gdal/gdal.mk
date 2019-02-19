gdal-x86/%: proj-x86/4.9.3 curl-x86/7.64.0 geos-x86/3.6.2
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=i686-linux-android \
		--build-arg TOOLCHAIN=x86-4.9 \
		--build-arg ARCH=x86 \
		-t bad-gdal:${@F}-x86 -f gdal/gdal.Dockerfile ${BUILD_ARGS} .

gdal-armv7-a/%: proj-armv7-a/4.9.3 curl-armv7-a/7.64.0 geos-armv7-a/3.6.2
	docker build --build-arg VERSION=${@F} \
		-t bad-gdal:${@F}-armv7-a -f gdal/gdal.Dockerfile ${BUILD_ARGS} .

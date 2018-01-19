spatialite-x86/%: sqlite3-x86/3.21.0 proj-x86/4.9.3 iconv-x86/1.15 geos-x86/3.6.2
	docker build --build-arg VERSION=${@F} \
		--build-arg STAND_TAG=r10e--android-21--x86-4.9 \
		--build-arg HOST=i686-linux-android \
		--build-arg ARCH=x86 \
		-t bad-spatialite:${@F}-x86 \
		-f spatialite/spatialite.Dockerfile ${BUILD_ARGS} .

spatialite-armv7-a/%: sqlite3-armv7-a/3.21.0 proj-armv7-a/4.9.3 iconv-armv7-a/1.15 geos-armv7-a/3.6.2
	docker build --build-arg VERSION=${@F} \
		-t bad-spatialite:${@F}-armv7-a \
		-f spatialite/spatialite.Dockerfile ${BUILD_ARGS} .

spatialite-x86/%: sqlite3-x86/3.21.0 proj-x86/4.9.3 iconv-x86/1.15 geos-x86/3.6.2
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=i686-linux-android \
		--build-arg ARCH=x86 \
		--build-arg TOOLCHAIN=x86-4.9 \
		-t bad-spatialite:${@F}-x86 \
		-f spatialite/spatialite.Dockerfile ${BUILD_ARGS} .

spatialite-arm64-v8a/%: sqlite3-arm64-v8a/3.21.0 proj-arm64-v8a/4.9.3 iconv-arm64-v8a/1.15 geos-arm64-v8a/3.6.2
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=aarch64-linux-android \
		--build-arg TOOLCHAIN=aarch64-linux-android-4.9 \
		--build-arg ARCH=arm64-v8a \
		-t bad-spatialite:${@F}-arm64-v8a \
		-f spatialite/spatialite.Dockerfile ${BUILD_ARGS} .

spatialite-armv7-a/%: sqlite3-armv7-a/3.21.0 proj-armv7-a/4.9.3 iconv-armv7-a/1.15 geos-armv7-a/3.6.2
	docker build --build-arg VERSION=${@F} \
		-t bad-spatialite:${@F}-armv7-a \
		-f spatialite/spatialite.Dockerfile ${BUILD_ARGS} .

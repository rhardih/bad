geos-x86/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg STAND_TAG=r10e--android-21--x86-4.9 \
		--build-arg HOST=i686-linux-android \
		-t bad-geos:${@F}-x86 -f geos/geos.Dockerfile ${BUILD_ARGS} .

geos-armv7-a/%:
	docker build --build-arg VERSION=${@F} \
		-t bad-geos:${@F}-armv7-a -f geos/geos.Dockerfile ${BUILD_ARGS} .

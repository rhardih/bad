expat-x86/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg STAND_TAG=r10e--android-21--x86-4.9 \
		--build-arg HOST=i686-linux-android \
		-t bad-expat:${@F}-x86 -f expat/expat.Dockerfile ${BUILD_ARGS} .

expat-armv7-a/%:
	docker build --build-arg VERSION=${@F} \
		-t bad-expat:${@F}-armv7-a -f expat/expat.Dockerfile ${BUILD_ARGS} .

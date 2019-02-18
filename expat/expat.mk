expat-x86/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=i686-linux-android \
		--build-arg TOOLCHAIN=x86-4.9 \
		-t bad-expat:${@F}-x86 -f expat/expat.Dockerfile ${BUILD_ARGS} .

expat-armv7-a/%:
	docker build --build-arg VERSION=${@F} \
		-t bad-expat:${@F}-armv7-a -f expat/expat.Dockerfile ${BUILD_ARGS} .

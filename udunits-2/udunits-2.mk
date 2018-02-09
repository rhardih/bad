udunits-2-x86/%: expat-x86/2.2.5
	docker build --build-arg VERSION=${@F} \
		--build-arg STAND_TAG=r10e--android-21--x86-4.9 \
		--build-arg HOST=i686-linux-android \
		-t bad-udunits-2:${@F}-x86 -f udunits-2/udunits-2.Dockerfile ${BUILD_ARGS} .

udunits-2-armv7-a/%: expat-armv7-a/2.2.5
	docker build --build-arg VERSION=${@F} \
		-t bad-udunits-2:${@F}-armv7-a -f udunits-2/udunits-2.Dockerfile ${BUILD_ARGS} .

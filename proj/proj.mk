proj-x86/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg STAND_TAG=r10e--android-21--x86-4.9 \
		--build-arg HOST=i686-linux-android \
		-t bad-proj:${@F}-x86 -f proj/proj.Dockerfile ${BUILD_ARGS} .

proj-armv7-a/%:
	docker build --build-arg VERSION=${@F} \
		-t bad-proj:${@F}-armv7-a -f proj/proj.Dockerfile ${BUILD_ARGS} .

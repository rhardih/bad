proj-x86/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=i686-linux-android \
		--build-arg TOOLCHAIN=x86-4.9 \
		-t bad-proj:${@F}-x86 -f proj/proj.Dockerfile ${BUILD_ARGS} .

proj-armv7-a/%:
	docker build --build-arg VERSION=${@F} \
		-t bad-proj:${@F}-armv7-a -f proj/proj.Dockerfile ${BUILD_ARGS} .

proj-x86/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=i686-linux-android \
		--build-arg TOOLCHAIN=x86-4.9 \
		-t bad-proj:${@F}-x86 -f proj/proj.Dockerfile ${BUILD_ARGS} .

proj-arm64-v8a/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=aarch64-linux-android \
		--build-arg TOOLCHAIN=aarch64-linux-android-4.9 \
		-t bad-proj:${@F}-arm64-v8a -f proj/proj.Dockerfile ${BUILD_ARGS} .

proj-armv7-a/%:
	docker build --build-arg VERSION=${@F} \
		-t bad-proj:${@F}-armv7-a -f proj/proj.Dockerfile ${BUILD_ARGS} .

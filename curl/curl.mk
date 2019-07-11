curl-x86/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=i686-linux-android \
		--build-arg TOOLCHAIN=x86-4.9 \
		-t bad-curl:${@F}-x86 -f curl/curl.Dockerfile ${BUILD_ARGS} .

curl-arm64-v8a/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=aarch64-linux-android \
		--build-arg TOOLCHAIN=aarch64-linux-android-4.9 \
		-t bad-curl:${@F}-arm64-v8a -f curl/curl.Dockerfile ${BUILD_ARGS} .

curl-armv7-a/%:
	docker build --build-arg VERSION=${@F} \
		-t bad-curl:${@F}-armv7-a -f curl/curl.Dockerfile ${BUILD_ARGS} .

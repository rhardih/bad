curl-x86/%: openssl-x86/1.1.1c
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=i686-linux-android \
		--build-arg TOOLCHAIN=x86-4.9 \
		--build-arg ARCH=x86 \
		-t bad-curl:${@F}-x86 -f curl/curl.Dockerfile ${BUILD_ARGS} .

curl-arm64-v8a/%: openssl-arm64-v8a/1.1.1c
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=aarch64-linux-android \
		--build-arg TOOLCHAIN=aarch64-linux-android-4.9 \
		--build-arg ARCH=arm64-v8a \
		-t bad-curl:${@F}-arm64-v8a -f curl/curl.Dockerfile ${BUILD_ARGS} .

curl-armv7-a/%: openssl-armv7-a/1.1.1c
	docker build --build-arg VERSION=${@F} \
		-t bad-curl:${@F}-armv7-a -f curl/curl.Dockerfile ${BUILD_ARGS} .

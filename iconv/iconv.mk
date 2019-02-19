iconv-x86/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=i686-linux-android \
		--build-arg TOOLCHAIN=x86-4.9 \
		-t bad-iconv:${@F}-x86 -f iconv/iconv.Dockerfile ${BUILD_ARGS} .

iconv-armv7-a/%:
	docker build --build-arg VERSION=${@F} \
		-t bad-iconv:${@F}-armv7-a -f iconv/iconv.Dockerfile ${BUILD_ARGS} .

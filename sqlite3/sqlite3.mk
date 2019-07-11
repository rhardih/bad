sqlite3-x86/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=i686-linux-android \
		--build-arg TOOLCHAIN=x86-4.9 \
		-t bad-sqlite3:${@F}-x86 -f sqlite3/sqlite3.Dockerfile ${BUILD_ARGS} .

sqlite3-arm64-v8a/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg HOST=aarch64-linux-android \
		--build-arg TOOLCHAIN=aarch64-linux-android-4.9 \
		-t bad-sqlite3:${@F}-arm64-v8a -f sqlite3/sqlite3.Dockerfile ${BUILD_ARGS} .

sqlite3-armv7-a/%:
	docker build --build-arg VERSION=${@F} \
		-t bad-sqlite3:${@F}-armv7-a -f sqlite3/sqlite3.Dockerfile ${BUILD_ARGS} .

sqlite3-x86/%:
	docker build --build-arg VERSION=${@F} \
		--build-arg STAND_TAG=r10e--android-21--x86-4.9 \
		--build-arg HOST=i686-linux-android \
		-t bad-sqlite3:${@F}-x86 -f sqlite3/sqlite3.Dockerfile ${BUILD_ARGS} .

sqlite3-armv7-a/%:
	docker build --build-arg VERSION=${@F} \
		-t bad-sqlite3:${@F}-armv7-a -f sqlite3/sqlite3.Dockerfile ${BUILD_ARGS} .

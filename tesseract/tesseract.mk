# Special case tesseract here, since different patches is needed in order for
# different versions to compile.

tesseract-x86/3.02.02: tiff-x86/4.0.9 leptonica-x86/1.74.4
	docker build \
		--build-arg STAND_TAG=r10e--android-21--x86-4.9 \
		--build-arg HOST=i686-linux-android \
		--build-arg ARCH=x86 \
		-t bad-tesseract:3.02.02-x86 \
		-f tesseract/tesseract-3.02.02.Dockerfile ${BUILD_ARGS} .

tesseract-armv7-a/3.02.02: tiff-armv7-a/4.0.9 leptonica-armv7-a/1.74.4
	docker build -t bad-tesseract:3.02.02-armv7-a \
		-f tesseract/tesseract-3.02.02.Dockerfile ${BUILD_ARGS} .

tesseract-x86/3.05.01: tiff-x86/4.0.9 leptonica-x86/1.74.4
	docker build \
		--build-arg STAND_TAG=r10e--android-21--x86-4.9 \
		--build-arg HOST=i686-linux-android \
		--build-arg ARCH=x86 \
		-t bad-tesseract:3.05.01-x86 \
		-f tesseract/tesseract-3.05.01.Dockerfile ${BUILD_ARGS} .

tesseract-armv7-a/3.05.01: tiff-armv7-a/4.0.10 leptonica-armv7-a/1.74.4
	docker build -t bad-tesseract:3.05.01-armv7-a \
		-f tesseract/tesseract-3.05.01.Dockerfile ${BUILD_ARGS} .

tesseract-x86/4.0.0: tiff-x86/4.0.9 leptonica-x86/1.74.4
	docker build \
		--build-arg STAND_TAG=r10e--android-21--x86-4.9 \
		--build-arg HOST=i686-linux-android \
		--build-arg ARCH=x86 \
		-t bad-tesseract:4.0.0-x86 \
		-f tesseract/tesseract-4.0.0.Dockerfile ${BUILD_ARGS} .

tesseract-armv7-a/4.0.0: tiff-armv7-a/4.0.9 leptonica-armv7-a/1.74.4
	docker build -t bad-tesseract:4.0.0-armv7-a \
		-f tesseract/tesseract-4.0.0.Dockerfile ${BUILD_ARGS} .

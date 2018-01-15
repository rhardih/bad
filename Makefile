sqlite3/%:
	docker build --build-arg VERSION=${@F} -t bad-sqlite3:${@F} \
		-f sqlite3.Dockerfile ${BUILD_ARGS} .

sqlite3:
	make sqlite3/3.21.0

proj:
	docker build -t bad-proj -f proj.Dockerfile ${BUILD_ARGS} .

iconv:
	docker build -t bad-iconv -f iconv.Dockerfile ${BUILD_ARGS} .

geos:
	docker build -t bad-geos -f geos.Dockerfile ${BUILD_ARGS} .

spatialite: sqlite3 proj iconv geos
	docker build -t bad-spatialite -f spatialite.Dockerfile ${BUILD_ARGS} .

openssl:
	docker build -t bad-openssl -f openssl.Dockerfile ${BUILD_ARGS} .

tiff:
	docker build -t bad-tiff -f tiff.Dockerfile ${BUILD_ARGS} .

leptonica: tiff
	docker build -t bad-leptonica -f leptonica.Dockerfile ${BUILD_ARGS} .

tesseract: leptonica
	docker build -t bad-tesseract -f tesseract.Dockerfile ${BUILD_ARGS} .

opencv: leptonica tesseract
	docker build -t bad-opencv -f opencv.Dockerfile ${BUILD_ARGS} .

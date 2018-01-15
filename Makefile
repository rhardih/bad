sqlite3/%:
	docker build --build-arg VERSION=${@F} -t bad-sqlite3:${@F} \
		-f sqlite3.Dockerfile ${BUILD_ARGS} .

sqlite3:
	make sqlite3/3.21.0

proj/%:
	docker build --build-arg VERSION=${@F} -t bad-proj:${@F} \
		-f proj.Dockerfile ${BUILD_ARGS} .

proj:
	make proj/4.9.3

iconv/%:
	docker build --build-arg VERSION=${@F} -t bad-iconv:${@F} \
		-f iconv.Dockerfile ${BUILD_ARGS} .

iconv:
	make iconv/1.15

geos/%:
	docker build --build-arg VERSION=${@F} -t bad-geos:${@F} \
		-f geos.Dockerfile ${BUILD_ARGS} .

geos:
	make geos/3.6.2

spatialite/%: sqlite3/3.21.0 proj/4.9.3 iconv/1.15 geos/3.6.2
	docker build --build-arg VERSION=${@F} -t bad-spatialite:${@F} \
		-f spatialite.Dockerfile ${BUILD_ARGS} .

spatialite:
	make spatialite/4.3.0a

openssl/%:
	docker build --build-arg VERSION=${@F} -t bad-openssl:${@F} \
		-f openssl.Dockerfile ${BUILD_ARGS} .

openssl:
	make openssl/1.0.2n

tiff/%:
	docker build --build-arg VERSION=${@F} -t bad-tiff:${@F} \
		-f tiff.Dockerfile ${BUILD_ARGS} .

tiff:
	make tiff/4.0.9

leptonica/%: tiff/4.0.9
	docker build --build-arg VERSION=${@F} -t bad-leptonica:${@F} \
		-f leptonica.Dockerfile ${BUILD_ARGS} .

leptonica:
	make leptonica/1.74.4

tesseract/%: leptonica/1.74.4
	docker build --build-arg VERSION=${@F} -t bad-tesseract:${@F} \
		-f tesseract.Dockerfile ${BUILD_ARGS} .

tesseract:
	make tesseract/3.05.01

opencv: leptonica tesseract
	docker build -t bad-opencv -f opencv.Dockerfile ${BUILD_ARGS} .

.PHONY: tesseract

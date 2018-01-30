include sqlite3/sqlite3.mk

sqlite3:
	make sqlite3-armv7-a/3.21.0

include proj/proj.mk

proj:
	make proj-armv7-a/4.9.3

include iconv/iconv.mk

iconv:
	make iconv-armv7-a/1.15

include geos/geos.mk

geos:
	make geos-armv7-a/3.6.2

include spatialite/spatialite.mk

spatialite:
	make spatialite-armv7-a/4.3.0a

include openssl/openssl.mk

openssl:
	make openssl-armv7-a/1.0.2n

include tiff/tiff.mk

tiff:
	make tiff-armv7-a/4.0.9

include leptonica/leptonica.mk

leptonica:
	make leptonica-armv7-a/1.74.4

include tesseract/tesseract.mk

tesseract:
	make tesseract-armv7-a/3.05.01

include opencv/opencv.mk

opencv:
	make opencv-armv7-a/3.4.0

.PHONY: sqlite3 proj iconv geos spatialite openssl tiff leptonica tesseract \
	opencv

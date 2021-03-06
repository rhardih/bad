include sqlite3/sqlite3.mk

sqlite3:
	make sqlite3-armv7-a/3.21.0

include proj/proj.mk

proj:
	make proj-armv7-a/4.9.3

include gdal/gdal.mk

gdal:
	make gdal-armv7-a/2.3.1

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
	make openssl-armv7-a/1.1.1c

include tiff/tiff.mk

tiff:
	make tiff-armv7-a/4.0.10

include leptonica/leptonica.mk

leptonica:
	make leptonica-armv7-a/1.74.4

include tesseract/tesseract.mk

tesseract:
	make tesseract-armv7-a/4.0.0

include opencv/opencv.mk

opencv:
	make opencv-armv7-a/3.4.5

include expat/expat.mk

expat:
	make expat-armv7-a/2.2.5

include udunits-2/udunits-2.mk

udunits-2:
	make udunits-2-armv7-a/2.2.26

include curl/curl.mk

curl:
	make curl-armv7-a/7.64.0

.PHONY: sqlite3 proj gdal iconv geos spatialite openssl tiff leptonica \
	tesseract opencv udunits-2 expat curl

sqlite3:
	docker build -t bad-libsqlite3 -f sqlite3.Dockerfile .

proj:
	docker build -t bad-libproj -f proj.Dockerfile .

iconv:
	docker build -t bad-libiconv -f iconv.Dockerfile .

geos:
	docker build -t bad-libgeos -f geos.Dockerfile .

spatialite: sqlite3 proj iconv geos
	docker build -t bad-libspatialite -f spatialite.Dockerfile .

openssl:
	docker build -t bad-libssl -f openssl.Dockerfile .

leptonica:
	docker build -t bad-liblept -f leptonica.Dockerfile .

tesseract: leptonica
	docker build -t bad-libtesseract -f tesseract.Dockerfile .

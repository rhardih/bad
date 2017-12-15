sqlite3:
	docker build -t bad-sqlite3 -f sqlite3.Dockerfile .

proj:
	docker build -t bad-proj -f proj.Dockerfile .

iconv:
	docker build -t bad-iconv -f iconv.Dockerfile .

geos:
	docker build -t bad-geos -f geos.Dockerfile .

spatialite: sqlite3 proj iconv geos
	docker build -t bad-spatialite -f spatialite.Dockerfile .

openssl:
	docker build -t bad-openssl -f openssl.Dockerfile .

leptonica:
	docker build -t bad-leptonica -f leptonica.Dockerfile .

tesseract: leptonica
	docker build -t bad-tesseract -f tesseract.Dockerfile .

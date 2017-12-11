sqlite:
	docker build -t bad-libsqlite3 -f Dockerfile.sqlite .

proj:
	docker build -t bad-libproj -f Dockerfile.proj .

iconv:
	docker build -t bad-libiconv -f Dockerfile.iconv .

geos:
	docker build -t bad-libgeos -f Dockerfile.geos .

spatialite: sqlite proj iconv geos
	docker build -t bad-libspatialite -f Dockerfile.spatialite .

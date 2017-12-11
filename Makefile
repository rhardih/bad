sqlite:
	docker build -t bad-libsqlite3 -f Dockerfile.sqlite .

proj:
	docker build -t bad-libproj -f Dockerfile.proj .

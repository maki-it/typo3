.PHONY: build build-slim xray profile

build:
	cd src; docker build -f Dockerfile -t typo3 .

build-slim:
	$(MAKE) build
	cd src; slim build --target typo3 --exclude-pattern=/var/lock

xray:
	slim xray typo3

profile:
	slim profile --env typo3

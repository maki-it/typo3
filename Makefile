.PHONY: build build-slim xray profile

build:
	cd src; docker build -f Dockerfile -t typo3 .

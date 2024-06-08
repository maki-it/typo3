.PHONY: build

build:
	cd src; docker build -f Dockerfile -t typo3 .
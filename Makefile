# Read the Docs - Build container images

DOCKER ?= $(shell which docker)


.PHONY: build base advanced

build: base advanced

base:
	docker build -t rtfd-build:base base/

advanced: base
	docker build -t rtfd-build:advanced advanced/

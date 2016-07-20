# Read the Docs - Build container images

DOCKER ?= $(shell which docker)
IMAGES = 14.04 14.04-advanced 16.04

.PHONY: images $(IMAGES) push

images: $(IMAGES)

push:
	docker push readthedocs/build:14.04
	docker push readthedocs/build:14.04-advanced
	docker push readthedocs/build:16.04

14.04: 14.04/Dockerfile
	docker build -t readthedocs/build:14.04 14.04/

14.04-advanced: 14.04-advanced/Dockerfile
	docker build -t readthedocs/build:14.04-advanced 14.04-advanced/

16.04: 16.04/Dockerfile
	docker build -t readthedocs/build:16.04 16.04/

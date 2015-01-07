.PHONY: build deploy destroy shell test

PORT_MAPPINGS := -p 4242:4242
IMAGE_NAME := hbase

default: build
build:
	docker build -t $(IMAGE_NAME) .
deploy:
	docker run -d $(PORT_MAPPINGS) $(IMAGE_NAME) > pid
destroy:
	docker rm -f $(shell cat pid) && rm pid
shell:
	docker run --rm $(PORT_MAPPINGS) -it $(IMAGE_NAME) /bin/bash

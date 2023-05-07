ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

# SHELL:=/bin/bash

.PHONY: lint

lint:
	clear
	docker run --rm \
	-e RUN_LOCAL=true \
	-e USE_FIND_ALGORITHM=true \
	-v $(ROOT_DIR):/tmp/lint \
	github/super-linter:slim-v5

.build: Dockerfile teleport-version
	touch .build
	touch .hystory
	docker build -t test -f Dockerfile .

run: .build
	docker run -it --rm \
	-v $(ROOT_DIR):/app \
	-v $(ROOT_DIR)/.hystory:/root/.bash_history \
	test
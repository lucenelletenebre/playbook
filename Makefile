ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

# SHELL:=/bin/bash

.PHONY: lint clean

lint:
	clear
	docker run --rm \
	-e RUN_LOCAL=true \
	-e USE_FIND_ALGORITHM=true \
	-v $(ROOT_DIR):/tmp/lint \
	github/super-linter:slim-v5

clean:
	if [ -f ".build" ]; then rm .build; fi
	# remove dangling immages
	docker rmi $(shell docker images -f dangling=true -q)

.build: Dockerfile teleport-version
	touch .build
	touch home/.bash_history
	docker build -t test -f Dockerfile .

run: .build
	docker run -it --rm \
	-v $(ROOT_DIR)/home:/root \
	test
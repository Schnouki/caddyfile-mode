CASK ?= cask

all: build

.PHONY: build clean test

build:
	$(CASK) build

clean:
	$(CASK) clean-elc

test:
	$(CASK) exec ert-runner --reporter ert+duration

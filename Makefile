CASK ?= cask

all: caddyfile-mode.elc

.PHONY: build clean lint test

.cask/.ok: Cask
	$(CASK) install
	touch .cask/.ok

caddyfile-mode.elc: .cask/.ok caddyfile-mode.el
	$(CASK) build

build: caddyfile-mode.elc

clean:
	$(CASK) clean-elc

lint: .cask/.ok
	$(CASK) emacs --batch -Q \
		--eval "(require 'package)" \
		--eval "(push '(\"melpa\" . \"https://melpa.org/packages/\") package-archives)" \
		--eval "(package-initialize)" \
		--eval "(package-refresh-contents)" \
		-l package-lint.el \
		-f package-lint-batch-and-exit caddyfile-mode.el

test: caddyfile-mode.elc
	$(CASK) exec ert-runner --reporter ert+duration

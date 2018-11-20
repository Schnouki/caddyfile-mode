CASK ?= cask

all: caddyfile-mode.elc

.PHONY: clean test

.cask/.ok: Cask
	$(CASK) install
	touch .cask/.ok

caddyfile-mode.elc: .cask/.ok caddyfile-mode.el
	$(CASK) build

clean:
	$(CASK) clean-elc

test: caddyfile-mode.elc
	$(CASK) exec ert-runner --reporter ert+duration

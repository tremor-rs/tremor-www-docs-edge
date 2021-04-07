TREMOR_VSN=main
SHELL = bash

.PHONY: pages pages/tremor-runtime

all: pages pages/mkdocs.yml

pages:
	-git clone https://github.com/tremor-rs/tremor-www-docs pages
	-cd pages && git checkout main && git pull origin main; cd -

pages/mkdocs.yml: pages/tremor-runtime
	$(MAKE) -C pages mkdocs.yml

pages/tremor-runtime:
	$(MAKE) -C pages tremor-runtime
	-cd pages/tremor-runtime && git checkout $(TREMOR_VSN) ; cd -

clean:
	-$(MAKE) -C pages clean
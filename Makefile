TREMOR_VSN=main

.PHONY: pages pages/tremor-runtime

all: pages pages/mkdocs.yml

pages:
	-git clone https://github.com/tremor-rs/tremor-www-docs pages
	-pushd pages && git checkout main && git pull origin main; popd

pages/mkdocs.yml: pages/tremor-runtime
	$(MAKE) -C pages mkdocs.yml

pages/tremor-runtime:
	$(MAKE) -C pages tremor-runtime
	-pushd pages/tremor-runtime && git checkout $(TREMOR_VSN) ; popd

clean:
	-$(MAKE) -C pages clean
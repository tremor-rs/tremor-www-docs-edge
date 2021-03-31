TREMOR_VSN=main

.PHONY: pages

all: pages/docs/tremor-script/stdlib pages/docs/operations/cli.md

thunk:
	-git clone https://github.com/tremor-rs/tremor-www-docs pages

tremor-runtime: thunk
	-git clone https://github.com/tremor-rs/tremor-runtime
	cd tremor-runtime &&\
	git checkout $(TREMOR_VSN)

pages/docs/tremor-script/stdlib: tremor-runtime
	cd tremor-runtime && make stdlib-doc
	-rm -r docs/tremor-script/stdlib
	cp -r tremor-runtime/docs pages/docs/tremor-script/stdlib

pages/docs/operations/cli.md: tremor-runtime
	./pages/cli2md/cli2md.py tremor-runtime/tremor-cli/src/cli.yaml > pages/docs/operations/cli.md

TREMOR_VSN=main

.PHONY: pages

all: pages/docs/tremor-script/stdlib pages/docs/operations/cli.md pages/mkdocs.yml

pages/mkdocs.yml:
	files=`find pages/docs/tremor-script/stdlib -type f`;\
	idx=$$(for f in $$files; do \
		name=`echo $$f | sed -e 's;pages/docs/tremor-script/stdlib/\(.*\).md;\1;' | sed -e 's;/;::;'`;\
		file=`echo $$f | sed -e 's;pages/docs/;;'`;\
		echo "$${name}0      - '$$name': $$file";\
	done | sort | sed -e 's/^.*\?0//' | awk 1 ORS='\\n');\
	sed -e "s;      - STDLIB;$${idx};" pages/mkdocs.yml.in > pages/mkdocs.yml

tremor-runtime:
	-git clone https://github.com/tremor-rs/tremor-runtime

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

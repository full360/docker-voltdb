VOLTDB_COM_TAG ?= 6.4

all: \
	clean \
	copy-files \
	build-image

clean:
	@rm -rf $(CURDIR)/voltdb-com-*

copy-files:
	@sh -c "'$(CURDIR)/scripts/copy-files.sh'"

build-image:
	@docker build --no-cache -t albertogg/voltdb-com:$(VOLTDB_COM_TAG) .

.PHONY: all clean copy-files build-image

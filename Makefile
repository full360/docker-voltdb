VOLTDB_COM_TAG ?= 6.4

all: \
	copy-files \
	build-files

copy-files:
	@sh -c "'$(CURDIR)/scripts/copy-files.sh'"

build-image:
	@docker build --no-cache -t albertogg/voltdb-com:$(VOLTDB_COM_TAG) .

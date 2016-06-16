VOLTDB_COM_VERSION ?= 6.4

all: \
	copy-files \
	build-files

copy-files:
	VOLTDB_COM_VERSION=$(VOLTDB_COM_VERSION) @sh -c "'$(CURDIR)/scripts/copy-files.sh'"

build-image:
	@docker build --no-cache -t albertogg/voltdb-com:$(VOLTDB_COM_VERSION) .

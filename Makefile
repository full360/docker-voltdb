VOLTDB_COM_VERSION ?= 6.4

all: \
	copy-files \
	build-files

copy-files:
	@sh -c "'$(CURDIR)/scripts/copy-files.sh'"

build-files:
	@docker build --no-cache -t albertogg/voltdb-com:$(VOLTDB_COM_VERSION) .

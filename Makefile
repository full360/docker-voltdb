DOCKER_USER ?= full360
VOLTDB_COM ?= voltdb-com
VOLTDB_COM_TAG_PATCH ?= 6.4.0
VOLTDB_COM_TAG_MINOR ?= 6.4
VOLTDB_COM_TAG_MAJOR ?= 6

all: \
	build-image

build-image:
	@docker build --no-cache -t $(DOCKER_USER)/$(VOLTDB_COM):$(VOLTDB_COM_TAG_PATCH) . && \
		@docker tag -f $(DOCKER_USER)/$(VOLTDB_COM):$(VOLTDB_COM_TAG_PATCH) $(DOCKER_USER)/$(VOLTDB_COM):$(VOLTDB_COM_MINOR) && \
		@docker tag -f $(DOCKER_USER)/$(VOLTDB_COM):$(VOLTDB_COM_TAG_PATCH) $(DOCKER_USER)/$(VOLTDB_COM):$(VOLTDB_COM_MAJOR) && \
		@docker tag -f $(DOCKER_USER)/$(VOLTDB_COM):$(VOLTDB_COM_TAG_PATCH) $(DOCKER_USER)/$(VOLTDB_COM):latest

push-image:
	@docker push $(DOCKER_USER)/$(VOLTDB_COM)

.PHONY: all build-image push-image

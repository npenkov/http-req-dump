VERSION := $(shell cat VERSION)
DOCKER_REPO := "npenkov/http-req-dump"

.PHONY: build
build: 
	docker build -t $(DOCKER_REPO):$(VERSION) .

.PHONY: push
push:
	docker tag $(DOCKER_REPO):$(VERSION) $(DOCKER_REPO):latest
	docker push $(DOCKER_REPO):$(VERSION)
	docker push $(DOCKER_REPO):latest
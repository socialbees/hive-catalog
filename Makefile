REGISTRY = gcr.io
NAME = $(REGISTRY)/hc-public/socialbee/catalog
VERSION = 0.0.1

.PHONY: build clean

build:
	go build server.go
	docker build -t $(NAME):$(VERSION) --rm .
	docker tag $(NAME):$(VERSION) $(NAME):latest

release: build
	gcloud docker push $(NAME)

deploy: release
	kubectl apply -f kube

clean:
	rm server
	docker rmi -f $(NAME):$(VERSION)

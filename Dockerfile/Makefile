.DEFAULT_GOAL := help

export
NOW = $(shell date '+%Y%m%d-%H%M%S')
ENV_VAL := "Hello world"

IMAGE_TAG = 0.0.3

.PHONY: build
build: ## Build container image
	docker build -t localhost:32000/fastchat:$(IMAGE_TAG) .

.PHONY: push
push: ## Push container image to local registry
	docker push localhost:32000/fastchat:$(IMAGE_TAG)


.PHONY: check-env
check-env: ## Check environment variables
	env | grep -E "(NOW|ENV_VAL)" || true

.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[38;2;98;209;150m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

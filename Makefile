.DEFAULT_GOAL := help

export
NOW = $(shell date '+%Y%m%d-%H%M%S')
ENV_VAL := "Hello world"

.PHONY: up-controller
up-controller: ## Start controller
	cd ./fastchat-controller && helm upgrade --install fastchat-controller .

.PHONY: up-model-worker
up-model-worker: ## Start model-worker
	cd ./fastchat-model-worker && helm upgrade --install fastchat-model-worker .

.PHONY: up-api-server
up-api-server: ## Start api-server
	cd ./fastchat-api-server && helm upgrade --install fastchat-api-server .

.PHONY: up-web-server
up-web-server: ## Start web-server
	cd ./fastchat-web-server && helm upgrade --install fastchat-web-server .

.PHONY: down
down: ## Stop all services
	helm uninstall fastchat-controller fastchat-model-worker fastchat-api-server fastchat-web-server


.PHONY: check-env
check-env: ## Check environment variables
	env | grep -E "(NOW|ENV_VAL)" || true

.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[38;2;98;209;150m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

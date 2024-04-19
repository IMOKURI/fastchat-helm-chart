.DEFAULT_GOAL := help

export
NOW = $(shell date '+%Y%m%d-%H%M%S')
ENV_VAL := "Hello world"

.PHONY: up-controller
up-controller: ## Start controller
	cd ./fastchat-controller && helm upgrade --install fastchat-controller .

.PHONY: up-model-worker
up-model-worker: ## Start model-worker
	cd ./fastchat-model-worker && helm upgrade --install fastchat-model-worker . \
		--set fullnameOverride=fastchat-model-worker-vicuna-7b \
		--set model.name=vicuna-7b-v1.5 \
		--set model.path=lmsys/vicuna-7b-v1.5 \
		--set service.port=21000 \
		--set resources.limits."nvidia\.com/gpu"=1

.PHONY: up-api-server
up-api-server: ## Start api-server
	cd ./fastchat-api-server && helm upgrade --install fastchat-api-server .

.PHONY: up-web-server
up-web-server: ## Start web-server
	cd ./fastchat-web-server && helm upgrade --install fastchat-web-server .

.PHONY: down
down: ## Stop all services
	helm uninstall fastchat-web-server || :
	helm uninstall fastchat-api-server || :
	helm uninstall fastchat-model-worker || :
	helm uninstall fastchat-controller


.PHONY: check-env
check-env: ## Check environment variables
	env | grep -E "(NOW|ENV_VAL)" || true

.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[38;2;98;209;150m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

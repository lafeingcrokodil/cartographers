help: ## List available targets.
	@ echo "Available targets in the Makefile:"
	@ awk -F ':|##' '/^[^\t].+?:.*?##/ {printf " %-30s %s\n", $$1, $$NF}' $(MAKEFILE_LIST) | sort

build: ## Compile the code into an executable.
	@ mkdir -p bin
	@ VERSION=$$(git describe --tag --always --dirty) && \
		go build -o bin/cartographers -ldflags "-X main.version=$$VERSION" \
		cmd/main.go

lint: ## Check code style.
	@ golangci-lint run ./...

docker-lint: ## Check code style in a local Docker container.
	@ docker pull golangci/golangci-lint:latest
	@ docker run -v `pwd`:/workspace -w /workspace golangci/golangci-lint:latest \
		make lint

test: ## Run tests.
	@ go test -coverpkg ./... -race ./...

docker-test: ## Run tests in a local Docker container.
	@ docker pull golang:1
	@ docker run -v `pwd`:/workspace -w /workspace golang:1 \
		make test

run: ## Run the cartographers program.
	@ go run cmd/main.go

docker-run: ## Run the cartographers program in a local Docker container.
	@ docker build -t cartographers .
	@ docker run --rm -p 8080:8080 cartographers

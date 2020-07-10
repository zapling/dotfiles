.PHONY: all build start tests
all: build start

build:
	[ -d build ] || mkdir build
	go build -v -o build/ ./cmd/weather-yr.no/

start:
	build/./weather-yr.no

tests:
	go test -cover ./internal/...

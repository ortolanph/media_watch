.PHONY: build run test

define check_installed
	@which $(1) > /dev/null 2>&1 || (echo "Error: '$(1)' is not installed" >&2 && exit 1)
endef

test:
	$(call check_installed,flutter)
	flutter test

clean:
	$(call check_installed,flutter)
	flutter clean cache
	flutter clean

dependencies:
	$(call check_installed,dart)
	dart pub get

compile: clean dependencies
	$(call check_installed,flutter)
	$(call check_installed,dart)
	dart run build_runner build -d

analyze:
	$(call check_installed,dart)
	dart analyze

fix: analyze
	$(call check_installed,dart)
	dart fix --apply

build: clean compile
	$(call check_installed,dart)
	$(call check_installed,flutter)
	flutter build web --base-href /tvshows/

docker-build:
	$(call check_installed,docker)
	@if docker image inspect media_watch:old > /dev/null 2>&1; then \
		echo "Removing media_watch:old..."; \
		docker rmi media_watch:old; \
	fi
	@if docker image inspect media_watch:latest > /dev/null 2>&1; then \
		echo "Tagging media_watch:latest as old..."; \
		docker tag media_watch:latest media_watch:old; \
	fi
	docker build -t media_watch:latest .

docker-run: build
	$(call check_installed,docker)
	docker run -d -p 8080:80 --name media_watch_application media_watch:latest
